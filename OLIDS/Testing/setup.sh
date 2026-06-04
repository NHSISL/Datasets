#!/usr/bin/env bash
#
# Sets up the OLIDS testing environment.
# Installs uv (if needed), creates a .env file with Snowflake credentials,
# and installs Python dependencies.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ""
echo "OLIDS Testing - Setup"
echo "====================="
echo ""

# --- Step 1: Check for uv ---
if ! command -v uv &>/dev/null; then
    echo "uv not found on PATH. Installing..."
    curl -LsSf https://astral.sh/uv/install.sh | sh

    # uv installs to ~/.local/bin or ~/.cargo/bin depending on the system.
    # Source the env file it creates and add both locations to PATH.
    for env_file in "$HOME/.local/bin/env" "$HOME/.cargo/env"; do
        if [ -f "$env_file" ]; then
            source "$env_file"
        fi
    done
    export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

    if ! command -v uv &>/dev/null; then
        echo "ERROR: uv installation succeeded but is still not on PATH."
        echo "Close and reopen your terminal, then run this script again."
        exit 1
    fi
    echo "uv installed successfully."
else
    echo "uv found: $(uv --version)"
fi

# --- Step 2: Snowflake credentials ---
ENV_FILE="$SCRIPT_DIR/.env"
NEEDS_SETUP=true

if [ -f "$ENV_FILE" ]; then
    echo ""
    echo "Existing Snowflake configuration found:"
    for key in SNOWFLAKE_ACCOUNT SNOWFLAKE_USER SNOWFLAKE_WAREHOUSE SNOWFLAKE_ROLE SNOWFLAKE_DATABASE; do
        val=$(grep "^${key}=" "$ENV_FILE" 2>/dev/null | cut -d= -f2- || true)
        if [ -n "$val" ]; then
            echo "  $key = $val"
        fi
    done
    echo ""
    read -rp "Keep these settings? (Y/n) " change
    if [ "$change" = "n" ] || [ "$change" = "N" ]; then
        rm "$ENV_FILE"
    else
        echo "Keeping existing credentials."
        NEEDS_SETUP=false
    fi
fi

if $NEEDS_SETUP && [ ! -f "$ENV_FILE" ]; then
    echo ""
    echo "Snowflake Connection Setup"
    echo "--------------------------"
    echo ""

    echo "Account identifier"
    echo "  In Snowflake (https://app.snowflake.com/), click your profile (bottom-left)"
    echo "  and copy the 'Account identifier' value from Account Details."
    echo "  Format: XXXXXXX-XXX  (e.g. ATKJNCU-NCL)"
    read -rp "  SNOWFLAKE_ACCOUNT: " account

    echo ""
    echo "Username (your Snowflake login, usually your NHS email)"
    read -rp "  SNOWFLAKE_USER: " user

    echo ""
    echo "Warehouse name"
    echo "  The compute warehouse to run queries against."
    read -rp "  SNOWFLAKE_WAREHOUSE: " warehouse

    echo ""
    echo "Role name"
    echo "  Your Snowflake role with read access to the OLIDS schemas."
    read -rp "  SNOWFLAKE_ROLE: " role

    echo ""
    echo "Database name"
    echo "  The ICB-specific OLIDS database (e.g. Data_Store_OLIDS_Alpha)."
    read -rp "  SNOWFLAKE_DATABASE: " database

    cat > "$ENV_FILE" <<EOF
SNOWFLAKE_ACCOUNT=$account
SNOWFLAKE_USER=$user
SNOWFLAKE_WAREHOUSE=$warehouse
SNOWFLAKE_ROLE=$role
SNOWFLAKE_DATABASE=$database
EOF

    echo ""
    echo "Credentials saved to $ENV_FILE"
fi

# --- Step 3: Install/update dependencies ---
echo ""
echo "Installing Python dependencies..."
cd "$SCRIPT_DIR"
uv lock
uv sync
echo "Dependencies installed."

# --- Done ---
echo ""
echo "Setup complete."
echo ""
echo "Run tests with:"
echo "  cd $SCRIPT_DIR"
echo "  uv run run_tests.py"
echo ""
echo "Note: The first run will open a browser tab for Snowflake SSO authentication."
echo ""
