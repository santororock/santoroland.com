(function ($) {
    "use strict";
    var warn = function (m) {
        if (window.console && window.console.warn) {
            window.console.warn("FeatherlightGallery: " + m);
        }
    };
    if ("undefined" === typeof $) {
        return warn("Too much lightness, Featherlight needs jQuery.");
    } else if (!$.featherlight) {
        return warn("Load the featherlight plugin before the gallery plugin");
    }
    var isTouchAware = "ontouchstart" in window || (window.DocumentTouch && document instanceof DocumentTouch),
        jQueryConstructor = $.event && $.event.special.swipeleft && $,
        hammerConstructor =
            window.Hammer &&
            function ($el) {
                var mc = new window.Hammer.Manager($el[0]);
                mc.add(new window.Hammer.Swipe());
                return mc;
            },
        swipeAwareConstructor = isTouchAware && (jQueryConstructor || hammerConstructor);
    if (isTouchAware && !swipeAwareConstructor) {
        warn("No compatible swipe library detected; one must be included before featherlightGallery for swipe motions to navigate the galleries.");
    }
    var callbackChain = {
        afterClose: function (_super, event) {
            var self = this;
            self.$instance.off("next." + self.namespace + " previous." + self.namespace);
            if (self._swiper) {
                self._swiper.off("swipeleft", self._swipeleft).off("swiperight", self._swiperight);
                self._swiper = null;
            }
            return _super(event);
        },
        beforeOpen: function (_super, event) {
            var self = this;
            self.$instance.on("next." + self.namespace + " previous." + self.namespace, function (event) {
                var offset = event.type === "next" ? +1 : -1;
                self.navigateTo(self.currentNavigation() + offset);
            });
            if (swipeAwareConstructor) {
                self._swiper = swipeAwareConstructor(self.$instance)
                    .on(
                        "swipeleft",
                        (self._swipeleft = function () {
                            self.$instance.trigger("next");
                        })
                    )
                    .on(
                        "swiperight",
                        (self._swiperight = function () {
                            self.$instance.trigger("previous");
                        })
                    );
                self.$instance.addClass(this.namespace + "-swipe-aware", swipeAwareConstructor);
            }
            self.$instance
                .find("." + self.namespace + "-content")
                .append(self.createNavigation("previous"))
                .append(self.createNavigation("next"));
            return _super(event);
        },
        beforeContent: function (_super, event) {
            var index = this.currentNavigation();
            var len = this.slides().length;
            this.$instance.toggleClass(this.namespace + "-first-slide", index === 0).toggleClass(this.namespace + "-last-slide", index === len - 1);
            return _super(event);
        },
        onKeyUp: function (_super, event) {
            var dir = { 37: "previous", 39: "next" }[event.keyCode];
            if (dir) {
                this.$instance.trigger(dir);
                return false;
            } else {
                return _super(event);
            }
        },
    };
    function FeatherlightGallery($source, config) {
        if (this instanceof FeatherlightGallery) {
            $.featherlight.apply(this, arguments);
            this.chainCallbacks(callbackChain);
        } else {
            var flg = new FeatherlightGallery($.extend({ $source: $source, $currentTarget: $source.first() }, config));
            flg.open();
            return flg;
        }
    }
    $.featherlight.extend(FeatherlightGallery, { autoBind: "[data-featherlight-gallery]" });
    $.extend(FeatherlightGallery.prototype, {
        previousIcon: "&#9664;",
        nextIcon: "&#9654;",
        galleryFadeIn: 300,
        galleryFadeOut: 100,
        slides: function () {
            if (this.filter) {
                return this.$source.find(this.filter);
            }
            return this.$source;
        },
        images: function () {
            warn("images is deprecated, please use slides instead");
            return this.slides();
        },
        currentNavigation: function () {
            return this.slides().index(this.$currentTarget);
        },
        navigateTo: function (index) {
            var self = this,
                source = self.slides(),
                len = source.length,
                $inner = self.$instance.find("." + self.namespace + "-inner");
            index = ((index % len) + len) % len;
            self.$currentTarget = source.eq(index);
            self.beforeContent();
            return $.when(self.getContent(), $inner.fadeTo(self.galleryFadeOut, 1.0)).always(function ($newContent) {
                self.setContent($newContent);
                self.afterContent();
                $newContent.fadeTo(self.galleryFadeIn, 1.0);
            });
        },
        createNavigation: function (target) {
            var self = this;
            return $('<span title="' + target + '" class="' + this.namespace + "-" + target + '"><span>' + this[target + "Icon"] + "</span></span>").click(function () {
                $(this).trigger(target + "." + self.namespace);
            });
        },
    });
    $.featherlightGallery = FeatherlightGallery;
    $.fn.featherlightGallery = function (config) {
        FeatherlightGallery.attach(this, config);
        return this;
    };
    $(document).ready(function () {
        FeatherlightGallery._onReady();
    });
})(jQuery);
