# Edit SAS URI on Line 30

# This is the dir that will be 'watched' for new files i.e. DC01.zip
TRIAGE_DIR="/opt/kapetriages/"
AZCOPYDIR="/home/forensics/azcopy_linux_amd64_10.23.0"

process_triage () {
    #Takes in the filename as arg1
    ZIP=$1
    echo "Got Zip name: $ZIP"

    # Get folder name
    DEVICETOTRIAGE=${ZIP%.*}
    echo "Got folder name: $DEVICETOTRIAGE"

    echo "Sleeping 30 to wait for file to finalise downloading"
    sleep 30
    echo "Slept, continuing"

    # Unzip and use the zip name as the folder name
    echo A | unzip /opt/kapetriages/$ZIP -d /opt/kapetriages/$DEVICETOTRIAGE
    echo "Triage zip extracted to: /opt/kapetriages/$DEVICETOTRIAGE/"

    # Run log2timeline and generate Plaso file
    log2timeline.py --storage-file /opt/kapetriages/$DEVICETOTRIAGE/$DEVICETOTRIAGE.plaso /opt/kapetriages/$DEVICETOTRIAGE/

    echo "Finished processing $DEVICETOTRIAGE via Plaso, now producing timeline via PSort."

    psort.py -o l2tcsv -w /opt/kapetriages/$DEVICETOTRIAGE/timeline_$DEVICETOTRIAGE.csv /opt/kapetriages/$DEVICETOTRIAGE/$DEVICETOTRIAGE.plaso

    Copy timeline to blob storage
    $AZCOPYDIR/azcopy copy "/opt/kapetriages/$DEVICETOTRIAGE/timeline_$DEVICETOTRIAGE.csv" "SASURIHERE"
}

# Use itnotify wait to look for new files moved to the triage directory.
# Format %f only prints the name of the file
# While read ZIP stores the filename in the variable zip
inotifywait -m -r -e create "/opt/kapetriages" --format "%f" | while read ZIP
do
# Use Bash string expansion to take the name of the file found and confirm the file is .zip.
    extension="${ZIP##*.}"
    if [[ $extension == "zip" ]]; then
    # Might want to change this to call the function in a seperate script so it doesn't miss any new creation events??
        process_triage $ZIP > output_$ZIP.log 2>&1 &
    fi
done
