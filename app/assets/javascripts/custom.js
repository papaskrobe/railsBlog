
//resizable quill editor (new/edit)
$(function() { $('.ql-container').resizable({handles: "s"}); });

//make url text (new/edit)
function makeURL(id) {
  var len = document.getElementById("url_length").value;
  if (len <= 0) {
    len = 25;
  } else if (len > 50) {
    len = 50;
  }
  var post_name = document.getElementById("post_title").value.toLowerCase().replace(/  */g, "_").replace(/[^a-z|0-9|"_"]/g, "").substring(0,len);
  id.value = post_name;
}

//make preview
function changeText(id) {
  id.innerHTML = document.getElementById('content_final').value;
}

