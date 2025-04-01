#!/bin/bash
set -e  # Exit on any error

# Architecture detection or allow override
ARCH=${2:-$(uname -m | sed 's/x86_64/amd64/' | sed 's/aarch64/arm64/' | sed 's/i386/386/' | sed 's/i686/386/' | sed 's/armv7l/armv6l/' | sed 's/armv8l/armv6l/')}

echo "Detected Architecture: $ARCH"

# Function to get the latest Go version using the download JSON data
get_latest_version() {   
    # Using the JSON data from golang.org that lists all versions
    LATEST_VERSION=$(curl -s https://go.dev/dl/?mode=json | grep -m 1 '"version"' | sed -E 's/.*"go([^"]+)".*/\1/')
    
    # If that fails, try the stable.txt file
    if [ -z "$LATEST_VERSION" ]; then
        echo "JSON method failed, trying stable.txt..."
        LATEST_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -n 1 | sed 's/go//')
    fi
    
    # If both methods fail, use a default fallback version
    if [ -z "$LATEST_VERSION" ]; then
        echo "Could not determine latest version. Using default fallback version."
        LATEST_VERSION="1.22.0"  # Fallback to a known version
    fi

    echo "$LATEST_VERSION"
}

# Use provided version or get the latest
if [ -n "$1" ]; then
    VERSION="$1"
    echo "Using specified version: $VERSION"
else
    VERSION=$(get_latest_version)
fi

# Print installation information
echo "Installing Go version $VERSION for $ARCH architecture..."

# Check if go is already installed.
if command -v go &> /dev/null; then
    read -p "Go is already installed. Do you want to update it? (y/n): " choice
    if [[ "$choice" != "y" ]]; then
        echo "Exiting without updating."
        exit 0
    fi
else
    echo "Go is not installed. Installing..."
fi

# Download Go
echo "Downloading go${VERSION}.linux-${ARCH}.tar.gz..."
if ! wget -L "https://golang.org/dl/go${VERSION}.linux-${ARCH}.tar.gz"; then
  echo "Failed to download Go."
  exit 1
fi

# Remove old Go installation
echo "Removing old Go installation..."
if [[ -d /usr/local/go ]]; then
  if ! sudo rm -rf /usr/local/go; then
    echo "Failed to remove old Go installation."
    exit 1
  fi
fi

# Extract new Go installation
echo "Extracting new Go installation..."
if ! sudo tar -C /usr/local -xzf go${VERSION}.linux-${ARCH}.tar.gz; then
  echo "Failed to extract Go."
  exit 1
fi

# Remove tar file
echo "Removing tar file..."
if ! sudo rm go${VERSION}.linux-${ARCH}.tar.gz; then
  echo "Failed to remove tar file."
  exit 1
fi

echo "Exporting to user path" 
export PATH=$PATH:/usr/local/go/bin

echo "Listing the latest go version: $(go version)" 


echo -e  "\nGo $VERSION installed successfully."
# Provide instructions for permanent PATH setup
echo "====================================================================="
echo "To make Go available permanently, add the following to your ~/.profile:"
cat << 'EOL'
if [ -d "/usr/local/go/bin" ] ; then
    PATH=$PATH:/usr/local/go/bin
fi
EOL
echo "====================================================================="
echo "Then run: source ~/.profile"

# If you want to add into ~/.bashrc, uncomment following
#echo "Adding Go to ~/.bashrc..."
#if grep -q "export PATH=\$PATH:/usr/local/go/bin" ~/.bashrc; then
  #echo "Go path already in ~/.bashrc."
#else
  #echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc
  #echo "Go path added to ~/.bashrc."
#fi