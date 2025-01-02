#!/bin/bash

display_welcome_message() {
    clear
    echo -e "\033[0;32m  _____        _____             __ _                  "
    echo -e "\033[0;32m |  __ \      / ____|           / _(_)                 "
    echo -e "\033[0;32m | |  | | ___| |     ___  _ __ | |_ _  __ _ _ __ ___   "
    echo -e "\033[0;32m | |  | |/ _ \ |    / _ \| '_ \|  _| |/ _\` | '__/ _ \ "
    echo -e "\033[0;32m | |__| |  __/ |___| (_) | | | | | | | (_| | | | (_) | "
    echo -e "\033[0;32m |_____/ \___|\_____\___/|_| |_|_| |_|\__, |_|  \___/  "
    echo -e "\033[0;32m                                       __/ |           "
    echo -e "\033[0;32m                                      |___/            "
    echo -e "\033[0m"

    created_by_text="Program created by: AnonKryptiQuz"
    ascii_width=54
    padding=$(( (ascii_width - ${#created_by_text}) / 2 ))
    printf "%${padding}s" ""
    echo -e "\033[0;31m$created_by_text\033[0m"
    echo ""
}

is_valid_url() {
    local url_pattern="^(http|https)://[a-zA-Z0-9.-]+(\.[a-zA-Z]{2,})?(/.*)?$"
    [[ $1 =~ $url_pattern ]]
}

get_base_url_or_file() {
    if [ -f /etc/bash_completion ]; then
        source /etc/bash_completion
    fi

    while true; do
        read -e -p "$(echo -e "\033[0;37m[?] Enter the base URL or the path to the file with URLs: \033[0m")" input

        if [[ -z "$input" ]]; then
            echo -e "\033[0;31m[!] You must provide a valid URL or file.\033[0m"
            echo -e "\033[1;33m[i] Press Enter to try again...\033[0m"
            read -r
            clear
            display_welcome_message
        elif [[ -f "$input" ]]; then
            if ! grep -q -e "http" "$input"; then
                echo -e "\033[0;31m[!] File does not contain valid URLs.\033[0m"
                echo -e "\033[1;33m[i] Press Enter to try again...\033[0m"
                read -r
                clear
                display_welcome_message
            else
                urls_from_file=true
                break
            fi
        elif is_valid_url "$input"; then
            base_url="$input"
            urls_from_file=false
            break
        else
            echo -e "\033[0;31m[!] Invalid URL or file path.\033[0m"
            echo -e "\033[1;33m[i] Press Enter to try again...\033[0m"
            read -r
            clear
            display_welcome_message
        fi
    done
}

check_wp_vulnerability() {
    local base_url="$1"
    local vuln_path="/wp-admin/setup-config.php?step=1"
    local full_url="${base_url%/}$vuln_path"

    echo -e "\033[1;33m[+] Checking: \033[0m\033[0;37m$base_url\033[0m"

    response=$(curl -s -o /dev/null -w "%{http_code}" "$full_url")
    if [[ "$response" -eq 200 ]]; then
        body=$(curl -s "$full_url")
        if echo "$body" | grep -q "Database Name"; then
            echo -e "\033[0;32m[!] Vulnerable: \033[0m\033[0;37m$full_url\033[0m"
            echo ""
            vulnerable_urls+=("$full_url")
            return 1
        else
            echo -e "\033[0;31m[i] Not Vulnerable: \033[0m\033[0;37m$full_url\033[0m"
        fi
    else
        echo -e "\033[0;31m[!] Failed to connect or invalid response: \033[0m\033[0;37m$full_url\033[0m"
    fi
    echo ""
    return 0
}

handle_exit() {
    echo -e "\n\033[0;31m[!] Program interrupted by the user. Exiting...\033[0m"
    exit 1
}

trap handle_exit SIGINT

save_results_to_file() {
    read -p "[?] Do you want to save the results to a file? y/n (Press enter for default N): " save_input
    save_input=$(echo "$save_input" | tr '[:upper:]' '[:lower:]')

    if [[ "$save_input" == "y" ]]; then
        output_file="scan_results_$(date +%Y%m%d%H%M%S).txt"
        echo ""
        echo -e "\033[1;33m[i] Saving results to $output_file...\033[0m"
        printf "%s\n" "${vulnerable_urls[@]}" > "$output_file"
        echo -e "\033[0;32m[i] Results saved to $output_file\033[0m"
    else
        echo -e "\033[0;31m[i] Results not saved.\033[0m"
    fi
}

main() {
    display_welcome_message
    get_base_url_or_file

    echo ""
    echo -e "\033[1;33m[i] Loading, Please Wait...\033[0m"
    sleep 3
    clear

    echo -e "\033[1;34m[i] Starting vulnerability check...\033[0m"
    echo ""

    start_time=$(date +%s)
    total_findings=0
    total_scanned=0
    vulnerable_urls=()

    if [ "$urls_from_file" = true ]; then
        while IFS= read -r base_url || [ -n "$base_url" ]; do
            base_url=$(echo $base_url | tr -d '\r')
            base_url=$(echo $base_url | xargs)
            if [[ -z "$base_url" ]]; then
                continue
            fi
            if is_valid_url "$base_url"; then
                ((total_scanned++))
                check_wp_vulnerability "$base_url"
                total_findings=$((total_findings + $?))
            else
                echo -e "\033[0;31m[!] Skipping invalid URL: $base_url\033[0m"
            fi
        done < "$input"
    else
        check_wp_vulnerability "$base_url"
        total_findings=$?
        total_scanned=1
    fi

    elapsed_time=$(( $(date +%s) - start_time ))

    echo -e "\033[1;33m[i] Scan finished!\033[0m"
    if [ "$urls_from_file" = true ]; then
        echo -e "\033[1;33m[i] Total Scanned: $total_scanned\033[0m"
    fi
    echo -e "\033[1;33m[i] Total Findings: $total_findings\033[0m"
    echo -e "\033[1;33m[i] Time Taken: ${elapsed_time} seconds.\033[0m"
    echo ""

    save_results_to_file
}

main
