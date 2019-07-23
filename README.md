# dhall-security-txt
[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

> Dhall renderer for security.txt

## Description
This repository includes types and a renderer in the [Dhall language](https://github.com/dhall-lang/dhall-lang) which generate security.txt files which are compliant with the [security.txt standard](https://securitytxt.org).

## Install
For stability, users are encouraged to import from a tagged release, not from the master branch, and to watch for new releases. This project does not yet have rigorous testing set up for it and new commits on the master branch are prone to break compatibility and are almost sure to change the import hash for the expression.

## Usage
An example is provided - `exampleSecurity.dhall`.

### CLI
Example render:
```bash
dhall-to-text <<< './render.dhall ./exampleSecurity.dhall' > security.txt
```

## Maintainer
[Ari Becker](https://github.com/ari-becker)

## Contributing
TBD

## License
[Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0) © Coralogix, Inc.
