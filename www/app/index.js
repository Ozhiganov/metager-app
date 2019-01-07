function boot () {
    var storage = window.localStorage;
    document.getElementById("key-input").value = storage.getItem("key");
}

function saveKey (value) {
    var storage = window.localStorage;
    storage.setItem("key", value);
}
