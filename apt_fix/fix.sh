#! /bin/bash
# shellcheck disable=SC2034
# shellcheck disable=SC2207
# shellcheck disable=SC2034
# shellcheck disable=SC2181

function Enter() {
    for i in {1..2}; do
        echo " "
    done
}

installation() { # Function For Install Packages In Script ( If Not Exists )
    for pkgs in "$@"; do
        if ! dpkg -s "$pkgs" >/dev/null 2>&1; then
            sudo apt install "$pkgs"
        fi
    done
}

randomMessages() {
    echo -e "\e[46m=========================================\e[0m"
    quotes=(
        "GNU/Linux: Freedom to choose!"
        "GNU/Linux: Power at your fingertips!"
        "GNU/Linux: Where coders feel at home."
        "GNU/Linux: Stability meets felexibility."
        "GNU/Linux: Open-source, Open Possibilities"
    )

    random_index=$((RANDOM % ${#quotes[@]})) # Select Random Message And Save in Variable
    echo -e "\e[36m${quotes[$random_index]}\e[0m"
    echo -e "\e[46m=========================================\e[0m"
}

installation libnotify-bin jq
notify-send "Relax And Wait a Few Minutes For Your Apt To Be Fix"

# Read & Execute Commands From json File

# ======================================================
# ============ Reading & Executing Commands ============
# While loop For Read Json Commands And Execute command

jq -r '.commands[]' config.json | while read -r cmd; do
    echo ">> Running $cmd"
    eval "$cmd"
    if [ $? -ne 0 ]; then
        echo "ERROR >> $cmd "
    fi
    echo " "
done

# ======================================================
# ======================================================

# Message Finished job Time
echo -e "\e[42mLinux:\e[0m  \e[31mApt Process Completed\e[0m \e[95m(Errors Fixed & Packages Upgraded)\e[0m"

Enter

randomMessages

Enter

echo -e "Created By CAgent_47"


# Scripted By CAgent_47
