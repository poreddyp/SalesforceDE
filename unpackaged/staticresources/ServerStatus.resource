// JavaScript to report real-time status of Salesforce servers
var serversStatus;
var inactiveServers = '<b style="color:red;">The following Salesforce servers are inactive</b>: <p>';
var inactive = false;

// This is where the actual xhr is made and other functions in this script are called from
function checkStatus() {
    document.getElementById("allActive").style.visibility = 'hidden';
    document.getElementById("allNotActive").style.visibility = 'hidden';
    var xhr = new XMLHttpRequest();
    xhr.open('GET', "https://api.status.salesforce.com/v1/instances", true);
    xhr.responseType = 'text';
    xhr.send();
    xhr.onload = function () {
        if (xhr.status === 200) {
            serversStatus = JSON.parse(xhr.responseText);
            showResponse();
        } // end if
        else {
            console.log('xhr failed with xhr status text:' + xhr.statusText);
            document.getElementById("allNotActive").innerHTML = 'Unable to make HTTP request to Salesforce API. Please contact system adminstrator.' + '<button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>';
            document.getElementById("allNotActive").style.visibility = 'visible';
        }
    } // end onload
} // end checkStatus()

// Capture the name of each inactive server
function showResponse() {
    for (i = 0; i < serversStatus.length; i++) {
        if (serversStatus[i].status !== 'OK') {
            inactiveServers += ' ' + serversStatus[i].key + ',&nbsp ';
            inactive = true;
        }
        else {
            //No need to capture server names if all servers are OK
        }
    }
    // If all servers are active
    if (inactive == true) {
        console.log('Inactive salesforce servers found');
        document.getElementById("allNotActive").innerHTML = inactiveServers;
        document.getElementById("allNotActive").style.visibility = 'visible';
    }
    // if any of the servers are inactive, display warning alert with list of inactive servers
    else {
        console.log('All salesforce servers are active');
        document.getElementById("allActive").innerHTML = '<b style="color:green;">All Salesforce servers are active</b>';
        document.getElementById("allActive").style.visibility = 'visible';
    }

}