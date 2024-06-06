#!/bin/bash

url="http://localhost:8000/api/v1/masjid-bilal-liege-4000-belgium/prayer-times"
response=$(curl -s -X GET "$url")

# Parser le JSON avec jq pour obtenir les horaires de prière
fajr=$(echo $response | jq -r '.fajr')
sunset=$(echo $response | jq -r '.sunset')
dohr=$(echo $response | jq -r '.dohr')
asr=$(echo $response | jq -r '.asr')
maghreb=$(echo $response | jq -r '.maghreb')
icha=$(echo $response | jq -r '.icha')

# Obtenir l'heure actuelle en format HH:MM
current_time=$(date +"%H:%M")

# son à jouer
sound_at_prayer="/usr/share/sounds/freedesktop/stereo/complete.oga"
# Comparer l'heure actuelle avec les horaires de prière et afficher la prochaine prière

# Fonction pour jouer le son
play_sound() {
    if command -v paplay &> /dev/null; then
        paplay $1
    elif command -v aplay &> /dev/null; then
        aplay $1
    else
        echo "No suitable sound player found"
    fi
}

# Comparer l'heure actuelle avec les horaires de prière et planifier le son pour la prochaine prière
if [[ "$current_time" < "$fajr" ]]; then
    next_prayer_time=$fajr
elif [[ "$current_time" < "$sunset" ]]; then
    next_prayer_time=$sunset
elif [[ "$current_time" < "$dohr" ]]; then
    next_prayer_time=$dohr
elif [[ "$current_time" < "$asr" ]]; then
    next_prayer_time=$asr
elif [[ "$current_time" < "$maghreb" ]]; then
    next_prayer_time=$maghreb
elif [[ "$current_time" < "$icha" ]]; then
    next_prayer_time=$icha
else
    next_prayer_time=$fajr
fi

# Affichage
if [[ "$current_time" < "$fajr" ]]; then
    echo "Fajr $fajr"
elif [[ "$current_time" < "$sunset" ]]; then
    echo "Chourouk $sunset"
elif [[ "$current_time" < "$dohr" ]]; then
    echo "Dohr $dohr"
elif [[ "$current_time" < "$asr" ]]; then
    echo "Asr $asr"
elif [[ "$current_time" < "$maghreb" ]]; then
    echo "Maghreb $maghreb"
elif [[ "$current_time" < "$icha" ]]; then
    echo "Icha $icha"
else
    echo "Fajr à $fajr demain"
fi
