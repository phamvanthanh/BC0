<script>
$('ul li').click(function() {
    $('ul li.active').removeClass('active');
    $(this).closest('li').addClass('active');
});

$('#carousel1 .carousel').carousel({
   interval: 1000
})
</script>
