#! /bin/bash
set -euo pipefail

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

/bin/bash -c "$(brew bundle)"

/bin/bash ./install.sh

