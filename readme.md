# Install Golang

This bash script automates the installation of the latest stable version of Go on your Linux system. It retrieves the most recent version directly from the official Golang website, ensuring you always install the latest release.

## Prerequisites

* A Linux-based operating system.
* `curl` for downloading the Go archive.
* `tar` for extracting the archive.
* `sudo` privileges for system-wide installation.

## Usage

1.  **Download the script:**

    ```bash
    wget https://raw.githubusercontent.com/kurianvarkey/install-go/main/install-go.sh
    ```

    Or, by clonning the repository:

    ```bash
    git clone https://github.com/kurianvarkey/install-go.git
    
    # Navigate to the script's directory
    cd install-go
    ```

2.  **Make the script executable:**

    ```bash
    chmod +x install-go.sh
    ```

3.  **Run the script with sudo:**

    For checking the latest version and install
    ```bash
    bash install-go.sh
    ```

    For specific version and install
     ```bash
    bash install-go.sh 1.24.1
    ```

     For specific version, arch and install
     ```bash
    bash install-go.sh 1.24.1 amd64
    ```

    The script will:

    * Retrieve the latest Go version.
    * Download the Go archive.
    * Ask for sudo privileges.
    * Extract the archive to `/usr/local/go`.
    * Add `/usr/local/go/bin` to your system's PATH.
    * Clean up the downloaded archive.
    * Inform you of successful installation.

4.  **Verify the installation:**

    After the script finishes, open a new terminal or source your profile and run:

    ```bash
    go version
    ```

    This should display the installed Go version.

## Notes

* This script installs Go in `/usr/local/go`.