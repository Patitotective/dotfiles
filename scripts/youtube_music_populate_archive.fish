#!/usr/bin/env fish
for file in (fd ".flac")
    set id (mediainfo --Output=JSON "$file" | jq --raw-output '.media.track[0].extra.purl' | string match --regex --groups-only 'v=([a-zA-Z0-9\-_]+)')
    echo "youtube $id" >>archive.txt
end
