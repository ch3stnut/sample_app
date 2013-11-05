(function($) {
    $.fn.extend( {
        limiter: function(limit, elem) {
            $(this).on("keyup focus", function() {
                setCount(this, elem);
            });
            function setCount(src, elem) {
                var chars = src.value.length;
                if (chars > limit) {
                    elem.addClass("text-danger");
                }
                else {
                    elem.removeClass("text-danger");
                }
                elem.html( limit - chars );
            }
            setCount($(this)[0], elem);
        }
    });
})(jQuery);