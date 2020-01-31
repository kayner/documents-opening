# documents-opening

A project for checking whether the contents of documents are displayed in ONLYOFFICE Documents.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Install dependencies required by Appium
```
sudo apt-get install build-essential \
curl git m4 ruby texinfo libbz2-dev \
libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev
```

Install linuxbrew
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
```

Export path variables
```
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"
```

Install gcc
```
brew install gcc
```

Install node
```
brew update
brew install node
brew link node
```

Install Appium
```
npm install -g appium
npm install wd
```

Install Appium doctor
```
npm install appium-doctor -g
```

After that run `appium-doctor` and fix all offences
### Installing
Install project dependencies
```
sudo bundle install
```

1. Configure your `config/config.json`

2. Create data folders `rake prepare:folders`

3. Put documents for opening to data folders

4. Connect devices for testing

5. Turn on debug mode on the devices and confirm RSA pairing

## Running

Run test an all connected devices `rake run`
