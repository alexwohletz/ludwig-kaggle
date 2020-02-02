# ludwig-kaggle 

Simple dockerfile forked from the Ludwig git repository to run Ludwig in an isolated container and pull /data from the host into the container.

## Features

- User is configured under Alex
- Kaggle api is installed.  To use, simply make sure to include your kaggle json API get in the same directory as the Dockerfile so it can be captured on build.
- Simple Windows script is included to run and start the terminal in interactive mode.