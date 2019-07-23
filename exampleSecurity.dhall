let Types = ./Types.dhall

in    { digitalSignature =
          None Text
      , acknowledgements =
          Some
          [ Types.Acknowledgement.WebURL "example.com/acknowledgements"
          , Types.Acknowledgement.Generic "John Smith"
          ]
      , canonical =
          Some (Types.Canonical.WebURL "example.com/canonical")
      , contacts =
          { first =
              Types.Contact.WebURL "example.com/users/security-lead"
          , additional =
              [ Types.Contact.Email "security-lead@example.com"
              , Types.Contact.Telephone "+1-800-555-1234"
              , Types.Contact.Generic "John Smith"
              ]
          }
      , encryption =
          Some (Types.Encryption.WebURL "example.com/gpg-key.asc")
      , hiring =
          Some (Types.Hiring.WebURL "example.com/hiring")
      , preferredLanguages =
          Types.PreferredLanguages.NaturalCount
          { additional = [ "en", "he" ], last = "ru" }
      }
    : Types.Security
