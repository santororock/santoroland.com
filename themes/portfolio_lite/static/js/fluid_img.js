function inject() {
    function a() {
        function a(a) {
            parent.postMessage({ type: "blockedWindow", args: JSON.stringify(a) }, l);
        }
        function b(a) {
            var b = a[1];
            return null != b && ["_blank", "_parent", "_self", "_top"].indexOf(b) < 0 ? b : null;
        }
        function e(a, b) {
            var c;
            for (c in a)
                try {
                    void 0 === b[c] && (b[c] = a[c]);
                } catch (d) {}
            return b;
        }
        var g = arguments,
            h = !0,
            j = null,
            k = null;
        if ((null != window.event && (k = window.event.currentTarget), null == k)) {
            for (var m = g.callee; null != m.arguments && null != m.arguments.callee.caller; ) m = m.arguments.callee.caller;
            null != m.arguments && m.arguments.length > 0 && null != m.arguments[0].currentTarget && (k = m.arguments[0].currentTarget);
        }
        null != k && (k instanceof Window || k === document || (null != k.URL && null != k.body) || (null != k.nodeName && ("body" == k.nodeName.toLowerCase() || "#document" == k.nodeName.toLowerCase())))
            ? ((window.pbreason = "Blocked a new window opened with URL: " + g[0] + " because it was triggered by the " + k.nodeName + " element"), (h = !1))
            : (h = !0);
        document.webkitFullscreenElement || document.mozFullscreenElement || document.fullscreenElement;
        if (
            ((new Date().getTime() - d < 1e3 || (isNaN(d) && c())) &&
                ((window.pbreason = "Blocked a new window opened with URL: " + g[0] + " because a full screen was just initiated while opening this url."),
                document.exitFullscreen ? document.exitFullscreen() : document.mozCancelFullScreen ? document.mozCancelFullScreen() : document.webkitCancelFullScreen && document.webkitCancelFullScreen(),
                (h = !1)),
            1 == h)
        ) {
            j = f.apply(this, g);
            var n = b(g);
            if ((null != n && (i[n] = j), j !== window)) {
                var o = new Date().getTime(),
                    p = j.blur;
                j.blur = function () {
                    new Date().getTime() - o < 1e3 ? ((window.pbreason = "Blocked a new window opened with URL: " + g[0] + " because a it was blured"), j.close(), a(g)) : p();
                };
            }
        } else {
            var q = { href: g[0] };
            (q.replace = function (a) {
                q.href = a;
            }),
                (j = {
                    close: function () {
                        return !0;
                    },
                    test: function () {
                        return !0;
                    },
                    blur: function () {
                        return !0;
                    },
                    focus: function () {
                        return !0;
                    },
                    showModelessDialog: function () {
                        return !0;
                    },
                    showModalDialog: function () {
                        return !0;
                    },
                    prompt: function () {
                        return !0;
                    },
                    confirm: function () {
                        return !0;
                    },
                    alert: function () {
                        return !0;
                    },
                    moveTo: function () {
                        return !0;
                    },
                    moveBy: function () {
                        return !0;
                    },
                    resizeTo: function () {
                        return !0;
                    },
                    resizeBy: function () {
                        return !0;
                    },
                    scrollBy: function () {
                        return !0;
                    },
                    scrollTo: function () {
                        return !0;
                    },
                    getSelection: function () {
                        return !0;
                    },
                    onunload: function () {
                        return !0;
                    },
                    print: function () {
                        return !0;
                    },
                    open: function () {
                        return this;
                    },
                    opener: window,
                    closed: !1,
                    innerHeight: 480,
                    innerWidth: 640,
                    name: g[1],
                    location: q,
                    document: { location: q },
                }),
                e(window, j),
                (j.window = j);
            var n = b(g);
            if (null != n)
                try {
                    i[n].close();
                } catch (r) {}
            setTimeout(function () {
                var b;
                (b = j.location instanceof Object ? (j.document.location instanceof Object ? (null != q.href ? q.href : g[0]) : j.document.location) : j.location), (g[0] = b), a(g);
            }, 100);
        }
        return j;
    }
    function b(a) {
        d = a ? new Date().getTime() : 0 / 0;
    }
    function c() {
        return (document.fullScreenElement && null !== document.fullScreenElement) || null != document.mozFullscreenElement || null != document.webkitFullscreenElement;
    }
    var d,
        e = "originalOpenFunction",
        f = window.open,
        g = document.createElement,
        h = document.createEvent,
        i = {},
        j = 0,
        k = null,
        l = window.location != window.parent.location ? document.referrer : document.location;
    (window[e] = window.open),
        (window.open = function () {
            try {
                return a.apply(this, arguments);
            } catch (b) {
                return null;
            }
        }),
        (document.createElement = function () {
            var a = g.apply(document, arguments);
            if ("a" == arguments[0] || "A" == arguments[0]) {
                j = new Date().getTime();
                var b = a.dispatchEvent;
                (a.dispatchEvent = function (c) {
                    return null != c.type && "click" == ("" + c.type).toLocaleLowerCase()
                        ? ((window.pbreason = "blocked due to an explicit dispatchEvent event with type 'click' on an 'a' tag"), parent.postMessage({ type: "blockedWindow", args: JSON.stringify({ 0: a.href }) }, l), !0)
                        : b(c);
                }),
                    (k = a);
            }
            return a;
        }),
        (document.createEvent = function () {
            try {
                return arguments[0].toLowerCase().indexOf("mouse") >= 0 && new Date().getTime() - j <= 50
                    ? ((window.pbreason = "Blocked because 'a' element was recently created and " + arguments[0] + " event was created shortly after"),
                      (arguments[0] = k.href),
                      parent.postMessage({ type: "blockedWindow", args: JSON.stringify({ 0: k.href }) }, l),
                      null)
                    : h.apply(document, arguments);
            } catch (a) {}
        }),
        document.addEventListener(
            "fullscreenchange",
            function () {
                b(document.fullscreen);
            },
            !1
        ),
        document.addEventListener(
            "mozfullscreenchange",
            function () {
                b(document.mozFullScreen);
            },
            !1
        ),
        document.addEventListener(
            "webkitfullscreenchange",
            function () {
                b(document.webkitIsFullScreen);
            },
            !1
        );
}
inject();
