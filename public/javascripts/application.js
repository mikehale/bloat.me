document.observe("dom:loaded", function() {
  var clip = new ZeroClipboard.Client();
  clip.addEventListener('complete', function(client, text) {
    clip.hide();
    $('x_copy_button').hide();
    $('x_copied').show();
  });
  clip.addEventListener('mouseDown', function(client) { 
    clip.setText($('bloatMeUrl').readAttribute('href'));
  });
  clip.glue('x_copy_button');
  Event.observe(window, 'resize', function() { clip.reposition() });
});


// broken since we don't have a copy function anymore:
//
// Event.observe(window, 'load', function() {
//   // Watch for user's click on "Auto Copy" checkbox
//   if ($('auto_copy'))
//     Event.observe('auto_copy', 'change', function(event) { document.cookie = 'auto_copy='+($F('auto_copy') ? 1 : 0); });
// 
//   // Perform auto-copy if prudent
//   if ((link = $$('#url.arrow a')).length && document.cookie.match(/auto_copy=1/))
//     copy();
// });