# documents-opening

A project for checking whether the contents of documents are displayed in ONLYOFFICE Documents for Android.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Install dependencies required by Appium

```shell
sudo apt-get install build-essential \
curl git m4 ruby texinfo libbz2-dev \
libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev
```

Install linuxbrew

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
```

Export path variables

```shell
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"
```

Install gcc

```shell
brew install gcc
```

Install node

```shell
brew update
brew install node
brew link node
```

Install Appium

```shell
npm install -g appium
npm install wd
```

Install Appium doctor

```shell
npm install appium-doctor -g
```

After that run `appium-doctor` and fix all offences

### Installing

Install project dependencies

```shell
sudo bundle install
```

1. Configure your `config.json`:

    ```json
    {
      "mode": "smoke/screenshot/export",
      "failures": "0...1000000",
      "capabilities": {
        "appActivity": "Activity name",
        "appPackage": "App package name",
        "autoGrantPermissions": "true/false",
        "automationName": "Automation driver name",
        "language": "Device language",
        "locale": "Device locale",
        "newCommandTimeout": "Timeount before driver will stop",
        "platformName": "Android"
      },
      "devices": [
        {
          "udid": "Device1 udid",
          "name": "Device1 name",
          "system_port": "Device1 system port",
          "appium_port": "Device1 appium port"
        },
        {
          "udid": "Device2 udid",
          "name": "Device2 name",
          "system_port": "Device2 system port",
          "appium_port": "Device2 appium port"
        }
      ]
    }
    ```

    Example:

    ```json
    {
      "mode": "screenshot",
      "failures": 3,
      "capabilities": {
        "appActivity": "app.editors.manager.ui.activities.login.SplashActivity",
        "appPackage": "com.onlyoffice.documents",
        "autoGrantPermissions": true,
        "automationName": "UiAutomator2",
        "language": "gb",
        "locale": "EN",
        "newCommandTimeout": "3600",
        "platformName": "Android"
      },
      "devices": [
        {
          "udid": "192.168.56.101:5555",
          "name": "Emulator 1",
          "system_port": 8501,
          "appium_port": 8601
        },
        {
          "udid": "192.168.56.102:5555",
          "name": "Emulator 2",
          "system_port": 8502,
          "appium_port": 8602
        }
      ]
    }
    ```

2. Create data folders `rake prepare:folders`

3. Put documents for opening to `files/deviceName/to_open`

4. Connect devices for testing

5. Turn on debug mode on the devices and confirm RSA pairing

## Running

Run test an all connected devices `rake run:all`
