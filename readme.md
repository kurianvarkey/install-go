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

    Or, if you have cloned the repository:

    ```bash
    # Navigate to the script's directory
    cd install-go
    ```

2.  **Make the script executable:**

    ```bash
    chmod +x install-go.sh
    ```

3.  **Run the script with sudo:**

    ```bash
    bash install-go.sh
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