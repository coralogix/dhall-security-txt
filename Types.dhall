let Acknowledgement = < WebURL : Text | Generic : Text >

let Canonical = < WebURL : Text | Generic : Text >

let Contact =
      < WebURL : Text | Email : Text | Telephone : Text | Generic : Text >

let Encryption = < WebURL : Text | Generic : Text >

let Hiring = < WebURL : Text | Generic : Text >

let PreferredLanguages =
      < NaturalCount : { last : Text, additional : List Text } | Empty >

let Security =
      { digitalSignature :
          Optional Text
      , acknowledgements :
          Optional (List Acknowledgement)
      , canonical :
          Optional Canonical
      , contacts :
          { first : Contact, additional : List Contact }
      , encryption :
          Optional Encryption
      , hiring :
          Optional Hiring
      , preferredLanguages :
          PreferredLanguages
      }

in  { Acknowledgement =
        Acknowledgement
    , Canonical =
        Canonical
    , Contact =
        Contact
    , Encryption =
        Encryption
    , Hiring =
        Hiring
    , PreferredLanguages =
        PreferredLanguages
    , Security =
        Security
    }
