$("#micropost_picture").bind("change", function() {
  var size_in_megabytes = this.files[0].size/Settings.size_byte/Settings.size_byte;
  if (size_in_megabytes > Settings.size_img) {
    alert(I18n.t("micropost.alert"));
  }
});
