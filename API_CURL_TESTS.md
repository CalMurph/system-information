# API Curl Tests

Run the Rails server first:

```bash
bin/rails server
```

These examples assume the API is running at:

```txt
http://localhost:3000
```

If you are uploading a file, make sure `new_info.txt` exists in the project root, or change the file path in the command.

## Get All Sysinfos

```bash
curl -i http://localhost:3000/api/sysinfos
```

Pretty JSON:

```bash
curl http://localhost:3000/api/sysinfos | jq
```

Show only IDs and names:

```bash
curl http://localhost:3000/api/sysinfos | jq '.[] | {id, name}'
```

## Get Sysinfo By ID

Replace `1` with the ID you want to fetch.

```bash
curl -i http://localhost:3000/api/sysinfos/1
```

Pretty JSON:

```bash
curl http://localhost:3000/api/sysinfos/1 | jq
```

Nicer format

```bash
curl -s http://localhost:3000/api/sysinfos/37 | jq '.json = (.json | fromjson)'
```

## Create Sysinfo With A File Upload

```bash
curl -i -X POST http://localhost:3000/api/sysinfos \
  -H "Accept: application/json" \
  -F "sysinfo[name]=Server 1" \
  -F "sysinfo[rack_pos]=A1" \
  -F "sysinfo[slots]=2" \
  -F "sysinfo[notes]=Main server" \
  -F "sysinfo[json]=@./new_info.txt"
```

## Create Sysinfo Without A File Upload

```bash
curl -i -X POST http://localhost:3000/api/sysinfos \
  -H "Accept: application/json" \
  -F "sysinfo[name]=No JSON Server" \
  -F "sysinfo[rack_pos]=C3" \
  -F "sysinfo[slots]=1" \
  -F "sysinfo[notes]=Created without upload"
```

## Update Sysinfo By ID

Replace `1` with the ID you want to update.

```bash
curl -i -X PATCH http://localhost:3000/api/sysinfos/1 \
  -H "Accept: application/json" \
  -F "sysinfo[name]=Updated Server 1" \
  -F "sysinfo[rack_pos]=B2" \
  -F "sysinfo[slots]=4" \
  -F "sysinfo[notes]=Updated notes"
```

## Update Sysinfo With A New File Upload

Replace `1` with the ID you want to update.

```bash
curl -i -X PATCH http://localhost:3000/api/sysinfos/1 \
  -H "Accept: application/json" \
  -F "sysinfo[name]=Updated Server 1" \
  -F "sysinfo[rack_pos]=B2" \
  -F "sysinfo[slots]=4" \
  -F "sysinfo[notes]=Updated notes" \
  -F "sysinfo[json]=@./new_info.txt"
```

## Delete Sysinfo By ID

Replace `1` with the ID you want to delete.

```bash
curl -i -X DELETE http://localhost:3000/api/sysinfos/1
```

Successful deletes should return:

```txt
HTTP/1.1 204 No Content
```

## Error Checks

Get a missing record:

```bash
curl -i http://localhost:3000/api/sysinfos/999999
```

Update a missing record:

```bash
curl -i -X PATCH http://localhost:3000/api/sysinfos/999999 \
  -H "Accept: application/json" \
  -F "sysinfo[name]=Should not work"
```

Delete a missing record:

```bash
curl -i -X DELETE http://localhost:3000/api/sysinfos/999999
```

## Helper Commands

Get the last created record:

```bash
curl http://localhost:3000/api/sysinfos | jq 'last'
```

Delete the last created record:

```bash
curl -X DELETE "http://localhost:3000/api/sysinfos/$(curl -s http://localhost:3000/api/sysinfos | jq 'last.id')"
```

