## automated pull tag save load and push docker images from directory to another
#!/bin/bash

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Registry details
SOURCE_REGISTRY="192.168.1.1:8443"
DESTINATION_REGISTRY="10.10.10.10:30762"

# Function to print colored text
print_color() {
    local color=$1
    local text=$2
    echo -e "${color}${text}${NC}"
}

# Function to display the menu
display_menu() {
    clear
    print_color $BLUE "===== Docker Operations Menu ====="
    print_color $CYAN "1. Pull image from source registry ($SOURCE_REGISTRY)"
    print_color $CYAN "2. Tag image for destination registry ($DESTINATION_REGISTRY)"
    print_color $CYAN "3. Save image as tar.gz file"
    print_color $CYAN "4. Load image from tar.gz file"
    print_color $CYAN "5. Push image to destination registry ($DESTINATION_REGISTRY)"
    print_color $RED "6. Exit"
    echo
}

# Main script
print_color $GREEN "Welcome to the Docker Operations Script!"
echo
read -p "$(print_color $YELLOW "Enter the service name (e.g., proj): ")" SERVICE_NAME
read -p "$(print_color $YELLOW "Enter the tag (e.g., 1.22.0): ")" TAG

while true; do
    display_menu
    read -p "$(print_color $MAGENTA "Which operation do you want to perform? ")" OPERATION

    case $OPERATION in
        1)
            print_color $CYAN "Pulling image from $SOURCE_REGISTRY/$SERVICE_NAME:$TAG"
            docker pull $SOURCE_REGISTRY/$SERVICE_NAME:$TAG
            ;;
        2)
            print_color $CYAN "Tagging image for $DESTINATION_REGISTRY/$SERVICE_NAME:$TAG"
            docker tag $SOURCE_REGISTRY/$SERVICE_NAME:$TAG $DESTINATION_REGISTRY/$SERVICE_NAME:$TAG
            ;;
        3)
            FILENAME="${SERVICE_NAME}_${TAG//:/_}.tar.gz"
            print_color $CYAN "Saving image as $FILENAME"
            docker save -o $FILENAME $DESTINATION_REGISTRY/$SERVICE_NAME:$TAG
            ;;
        4)
            FILENAME="${SERVICE_NAME}_${TAG//:/_}.tar.gz"
            if [[ ! -f "$FILENAME" ]]; then
                print_color $RED "Image file '$FILENAME' does not exist."
            else
                print_color $CYAN "Loading image from $FILENAME"
                docker load -i $FILENAME
            fi
            ;;
        5)
            print_color $CYAN "Pushing image to $DESTINATION_REGISTRY/$SERVICE_NAME:$TAG"
            docker push $DESTINATION_REGISTRY/$SERVICE_NAME:$TAG
            ;;
        6)
            print_color $GREEN "Exiting script. Goodbye!"
            exit 0
            ;;
        *)
            print_color $RED "Invalid option. Please try again."
            ;;
    esac

    echo
    read -p "$(print_color $YELLOW "Press Enter to continue...")"
    # The script will automatically loop back to the menu
done
