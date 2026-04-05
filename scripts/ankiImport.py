#!/usr/bin/env python
import sys
import os
import glob
from anki.collection import Collection, ImportCsvRequest

anki_home = glob.glob(os.path.expanduser("~/.local/share/Anki2/User*"))[0]
col_path = os.path.join(anki_home, "collection.anki2")
col = Collection(col_path)

try:
    for path in sys.argv[1:]:
        metadata = col.get_csv_metadata(path=path, delimiter=None)
        request = ImportCsvRequest(path=path, metadata=metadata)
        response = col.import_csv(request)

        print(f"Importing: {os.path.relpath(path)}")
        print(f"Found: {response.log.found_notes}")
        print(f"Updated: {len(response.log.updated)}")
        print(f"New: {len(response.log.new)}\n")
finally:
    col.close()
