pushd apps/infra-couchdb

# Get admin password
ADMIN_PASSWD="$(kubectl get secrets -n infra-couchdb infra-couchdb -o json | jq -r '.data.adminPassword' | base64 -d)"

# Get the user name and password
USER_NAME="$(kubectl get secrets -n infra-couchdb couchdb -o json | jq -r '.data.username' | base64 -d)"
USER_PASSWD="$(kubectl get secrets -n infra-couchdb couchdb -o json | jq -r '.data.password' | base64 -d)"

# Create the infra database
curl -X PUT http://admin:$ADMIN_PASSWD@localhost:5984/infra

# Add the design document for infra table
curl -X PUT http://admin:$ADMIN_PASSWD@localhost:5984/infra/_design/infra_views -H "Content-Type: application/json" -d @infra-design.json

# Create the user
cat user.json | envsubst > /tmp/user.json
curl -X PUT http://admin:$ADMIN_PASSWD@localhost:5984/_users/org.couchdb.user:$USER_NAME -H "Accept: application/json" -H "Content-Type: application/json" -d @/tmp/user.json

# Grant user access to the infra database
curl -X PUT http://admin:$ADMIN_PASSWD@localhost:5984/infra/_security -H "Content-Type: application/json" -d @infra-security.json

# Add documents to the infra database
curl -X POST http://admin:$ADMIN_PASSWD@localhost:5984/_bulk_docs -H "Content-Type: application/json" -d @infra-data.json

# Query the infra database
# All documents
curl -X GET http://$USER_NAME:$USER_PASSWD@localhost:5984/infra/_design/infra_views/_view/all -H "Accept: application/json" | jq '.'
# By name, get paul1
curl -X GET http://$USER_NAME:$USER_PASSWD@localhost:5984/infra/_design/infra_views/_view/by_name?key=%22paul1%22 | jq -r '.'
# By type, get vms
curl -X GET http://$USER_NAME:$USER_PASSWD@localhost:5984/infra/_design/infra_views/_view/by_type?key=%22vm%22 | jq -r '.' 
# By email
curl -X GET http://$USER_NAME:$USER_PASSWD@localhost:5984/infra/_design/infra_views/_view/by_email | jq -r '.' 

