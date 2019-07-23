let Prelude = https://prelude.dhall-lang.org/package.dhall

let Types = ./Types.dhall

let fieldRenderers =
      { webUrl =
          λ(webUrl : Text) → "https://${webUrl}"
      , email =
          λ(email : Text) → "mailto:${email}"
      , telephone =
          λ(telephone : Text) → "tel:${telephone}"
      , generic =
          λ(generic : Text) → generic
      }

let render
    : Types.Security → Text
    =   λ ( security
          : Types.Security
          )
      → let beginSignedMessage
            : Text
            = Prelude.Optional.fold
              Text
              security.digitalSignature
              Text
              (λ(_ : Text) → "-----BEGIN PGP SIGNED MESSAGE-----\n")
              ""
        
        let acknowledgements
            : Text
            = Prelude.Optional.fold
              (List Types.Acknowledgement)
              security.acknowledgements
              Text
              (   λ(acknowledgements : List Types.Acknowledgement)
                → Prelude.List.fold
                  Text
                  ( Prelude.List.map
                    Types.Acknowledgement
                    Text
                    (   λ(acknowledgement : Types.Acknowledgement)
                      → let text =
                              merge
                              { WebURL =
                                  fieldRenderers.webUrl
                              , Generic =
                                  fieldRenderers.generic
                              }
                              acknowledgement
                        
                        in  ''
                            Acknowledgement: ${text}
                            ''
                    )
                    acknowledgements
                  )
                  Text
                  (   λ(thisAcknowledgement : Text)
                    → λ(thatAcknowledgement : Text)
                    → "${thisAcknowledgement}${thatAcknowledgement}"
                  )
                  ""
              )
              ""
        
        let canonical
            : Text
            = Prelude.Optional.fold
              Types.Canonical
              security.canonical
              Text
              (   λ(canonical : Types.Canonical)
                → let text =
                        merge
                        { WebURL =
                            fieldRenderers.webUrl
                        , Generic =
                            fieldRenderers.generic
                        }
                        canonical
                  
                  in  ''
                      Canonical: ${text}
                      ''
              )
              ""
        
        let contacts
            : Text
            = let render =
                      λ(contact : Types.Contact)
                    → let text =
                            merge
                            { WebURL =
                                fieldRenderers.webUrl
                            , Email =
                                fieldRenderers.email
                            , Telephone =
                                fieldRenderers.telephone
                            , Generic =
                                fieldRenderers.generic
                            }
                            contact
                      
                      in  ''
                          Contact: ${text}
                          ''
              
              let first = render security.contacts.first
              
              let additional =
                    Prelude.List.fold
                    Text
                    ( Prelude.List.map
                      Types.Contact
                      Text
                      render
                      security.contacts.additional
                    )
                    Text
                    (   λ(thisContact : Text)
                      → λ(thatContact : Text)
                      → "${thisContact}${thatContact}"
                    )
                    ""
              
              in  "${first}${additional}"
        
        let encryption
            : Text
            = Prelude.Optional.fold
              Types.Encryption
              security.encryption
              Text
              (   λ(encryption : Types.Encryption)
                → let text =
                        merge
                        { WebURL =
                            fieldRenderers.webUrl
                        , Generic =
                            fieldRenderers.generic
                        }
                        encryption
                  
                  in  ''
                      Encryption: ${text}
                      ''
              )
              ""
        
        let hiring
            : Text
            = Prelude.Optional.fold
              Types.Hiring
              security.hiring
              Text
              (   λ(hiring : Types.Hiring)
                → let text =
                        merge
                        { WebURL =
                            fieldRenderers.webUrl
                        , Generic =
                            fieldRenderers.generic
                        }
                        hiring
                  
                  in  ''
                      Hiring: ${text}
                      ''
              )
              ""
        
        let preferredLanguages
            : Text
            = merge
              { NaturalCount =
                    λ ( preferredLanguages
                      : { additional : List Text, last : Text }
                      )
                  → let text =
                          Prelude.List.fold
                          Text
                          preferredLanguages.additional
                          Text
                          (   λ(thisLanguage : Text)
                            → λ(thatLanguage : Text)
                            → "${thisLanguage}, ${thatLanguage}"
                          )
                          preferredLanguages.last
                    
                    in  ''
                        Preferred-Languages: ${text}
                        ''
              , Empty =
                  ""
              }
              security.preferredLanguages
        
        let digitalSignature
            : Text
            = Prelude.Optional.fold
              Text
              security.digitalSignature
              Text
              (λ(digitalSignature : Text) → digitalSignature)
              ""
        
        in  "${beginSignedMessage}${acknowledgements}${canonical}${contacts}${encryption}${hiring}${preferredLanguages}${digitalSignature}"

in  render
