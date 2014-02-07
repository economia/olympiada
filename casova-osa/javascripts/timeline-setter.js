(function(e, t) {
    var n = window.TimelineSetter = window.TimelineSetter || {};
    n.VERSION = "0.3.2";
    var r = function(e) {
        e.bind = function(e, t) {
            var n = this._callbacks = this._callbacks || {};
            var r = n[e] = n[e] || [];
            r.push(t)
        };
        e.trigger = function(e) {
            if (!this._callbacks) return;
            var t = this._callbacks[e];
            if (!t) return;
            for (var n = 0; n < t.length; n++) t[n].apply(this, arguments)
        }
    };
    var i = function(e) {
        e.move = function(e, t) {
            if (!t.deltaX) return;
            if (_.isUndefined(this.currOffset)) this.currOffset = 0;
            this.currOffset += t.deltaX;
            this.el.css({
                left: this.currOffset
            })
        };
        e.zoom = function(e, t) {
            if (!t.width) return;
            this.el.css({
                width: t.width
            })
        }
    };
    var s = function(e, t) {
        e.$ = function(e) {
            return window.$(e, t)
        }
    };
    var o = "ontouchstart" in document;
    if (o) e.event.props.push("touches");
    var u = function(t) {
        function r(e) {
            e.preventDefault();
            n = {
                x: e.pageX
            };
            e.type = "dragstart";
            t.el.trigger(e)
        }

        function i(e) {
            if (!n) return;
            e.preventDefault();
            e.type = "dragging";
            e = _.extend(e, {
                deltaX: (e.pageX || e.touches[0].pageX) - n.x
            });
            n = {
                x: e.pageX || e.touches[0].pageX
            };
            t.el.trigger(e)
        }

        function s(e) {
            if (!n) return;
            n = null;
            e.type = "dragend";
            t.el.trigger(e)
        }
        var n;
        if (!o) {
            t.el.bind("mousedown", r);
            e(document).bind("mousemove", i);
            e(document).bind("mouseup", s)
        } else {
            var u;
            t.el.bind("touchstart", function(r) {
                var i = Date.now();
                var s = i - (u || i);
                var o = s > 0 && s <= 250 ? "doubletap" : "tap";
                n = {
                    x: r.touches[0].pageX
                };
                u = i;
                t.el.trigger(e.Event(o))
            });
            t.el.bind("touchmove", i);
            t.el.bind("touchend", s)
        }
    };
    var a = /WebKit\/533/.test(navigator.userAgent);
    var f = function(e) {
        function t(t) {
            t.preventDefault();
            var n = t.wheelDelta || -t.detail;
            if (a) {
                var r = n < 0 ? -1 : 1;
                n = Math.log(Math.abs(n)) * r * 2
            }
            t.type = "scrolled";
            t.deltaX = n;
            e.el.trigger(t)
        }
        e.el.bind("mousewheel DOMMouseScroll", t)
    };
    var l = function() {
        this.min = +Infinity;
        this.max = -Infinity
    };
    l.prototype.extend = function(e) {
        this.min = Math.min(e, this.min);
        this.max = Math.max(e, this.max)
    };
    l.prototype.width = function() {
        return this.max - this.min
    };
    l.prototype.project = function(e, t) {
        return (e - this.min) / this.width() * t
    };
    var c = function(e, t) {
        this.max = e.max;
        this.min = e.min;
        if (!t || !this.INTERVALS[t]) {
            var n = this.computeMaxInterval();
            this.maxInterval = this.INTERVAL_ORDER[n];
            this.idx = n
        } else {
            this.maxInterval = t;
            this.idx = _.indexOf(this.INTERVAL_ORDER, t)
        }
    };
    c.dateFormats = function(e) {
        var t = new Date(e);
        var n = {};
        var r = ["Jan.", "Feb.", "March", "April", "May", "June", "July", "Aug.", "Sept.", "Oct.", "Nov.", "Dec."];
        var i = t.getHours() > 12;
        var s = " " + (t.getHours() >= 12 ? "p.m." : "a.m.");
        n.month = r[t.getMonth()];
        n.year = t.getFullYear();
        n.date = n.month + " " + t.getDate() + ", " + n.year;
        var o;
        if (i) {
            o = t.getHours() - 12
        } else {
            o = t.getHours() > 0 ? t.getHours() : "12"
        }
        o += ":" + d(t.getMinutes());
        n.hourWithMinutes = o + s;
        n.hourWithMinutesAndSeconds = o + ":" + d(t.getSeconds()) + s;
        return c.formatter(t, n) || n
    };
    c.dateStr = function(e, t) {
        var n = new c.dateFormats(e);
        switch (t) {
            case "Millennium":
                return n.year;
            case "Quincentenary":
                return n.year;
            case "Century":
                return n.year;
            case "HalfCentury":
                return n.year;
            case "Decade":
                return n.year;
            case "Lustrum":
                return n.year;
            case "FullYear":
                return n.year;
            case "Month":
                return n.month + ", " + n.year;
            case "Week":
                return n.date;
            case "Date":
                return n.date;
            case "Hours":
                return n.hourWithMinutes;
            case "HalfHour":
                return n.hourWithMinutes;
            case "QuarterHour":
                return n.hourWithMinutes;
            case "Minutes":
                return n.hourWithMinutes;
            case "Seconds":
                return n.hourWithMinutesAndSeconds
        }
    };
    c.prototype = {
        INTERVALS: {
            Millennium: 693792e8,
            Quincentenary: 346896e8,
            Century: 94608e8,
            HalfCentury: 31536e8,
            Decade: 31536e7,
            Lustrum: 15768e7,
            FullYear: 31536e6,
            Month: 2592e6,
            Week: 6048e5,
            Date: 864e5,
            Hours: 36e5,
            HalfHour: 18e5,
            QuarterHour: 9e5,
            Minutes: 6e4,
            Seconds: 1e3
        },
        INTERVAL_ORDER: ["Seconds", "Minutes", "QuarterHour", "HalfHour", "Hours", "Date", "Week", "Month", "FullYear", "Lustrum", "Decade", "HalfCentury", "Century", "Quincentenary", "Millennium"],
        YEAR_FRACTIONS: {
            Millenium: 1e3,
            Quincentenary: 500,
            Century: 100,
            HalfCentury: 50,
            Decade: 10,
            Lustrum: 5
        },
        isAtLeastA: function(e) {
            return this.max - this.min > this.INTERVALS[e]
        },
        computeMaxInterval: function() {
            for (var e = 0; e < this.INTERVAL_ORDER.length; e++) {
                if (!this.isAtLeastA(this.INTERVAL_ORDER[e])) break
            }
            return e - 1
        },
        getMaxInterval: function() {
            return this.INTERVALS[this.INTERVAL_ORDER[this.idx]]
        },
        getYearFloor: function(e, t) {
            var n = this.YEAR_FRACTIONS[t] || 1;
            return (e.getFullYear() / n | 0) * n
        },
        getYearCeil: function(e, t) {
            if (this.YEAR_FRACTIONS[t]) return this.getYearFloor(e, t) + this.YEAR_FRACTIONS[t];
            return e.getFullYear()
        },
        getWeekFloor: function(e) {
            thisDate = new Date(e.getFullYear(), e.getMonth(), e.getDate());
            thisDate.setDate(e.getDate() - e.getDay());
            return thisDate
        },
        getWeekCeil: function(e) {
            thisDate = new Date(e.getFullYear(), e.getMonth(), e.getDate());
            thisDate.setDate(thisDate.getDate() + (7 - e.getDay()));
            return thisDate
        },
        getHalfHour: function(e) {
            return e.getMinutes() > 30 ? 30 : 0
        },
        getQuarterHour: function(e) {
            var t = e.getMinutes();
            if (t < 15) return 0;
            if (t < 30) return 15;
            if (t < 45) return 30;
            return 45
        },
        floor: function(e) {
            var t = new Date(e);
            var n = this.INTERVAL_ORDER[this.idx];
            var r = this.idx > _.indexOf(this.INTERVAL_ORDER, "FullYear") ? _.indexOf(this.INTERVAL_ORDER, "FullYear") : r;
            t.setFullYear(this.getYearFloor(t, n));
            switch (n) {
                case "Week":
                    t.setDate(this.getWeekFloor(t).getDate());
                    r = _.indexOf(this.INTERVAL_ORDER, "Week");
                case "HalfHour":
                    t.setMinutes(this.getHalfHour(t));
                case "QuarterHour":
                    t.setMinutes(this.getQuarterHour(t))
            }
            while (r--) {
                n = this.INTERVAL_ORDER[r];
                if (!_.include(["Week", "HalfHour", "QuarterHour"].concat(_.keys(this.YEAR_FRACTIONS)), n)) t["set" + n](n === "Date" ? 1 : 0)
            }
            return t.getTime()
        },
        ceil: function(e) {
            var t = new Date(this.floor(e));
            var n = this.INTERVAL_ORDER[this.idx];
            t.setFullYear(this.getYearCeil(t, n));
            switch (n) {
                case "Week":
                    t.setTime(this.getWeekCeil(t).getTime());
                    break;
                case "HalfHour":
                    t.setMinutes(this.getHalfHour(t) + 30);
                    break;
                case "QuarterHour":
                    t.setMinutes(this.getQuarterHour(t) + 15);
                    break;
                default:
                    if (!_.include(["Week", "HalfHour", "QuarterHour"].concat(_.keys(this.YEAR_FRACTIONS)), n)) t["set" + n](t["get" + n]() + 1)
            }
            return t.getTime()
        },
        span: function(e) {
            return this.ceil(e) - this.floor(e)
        },
        getRanges: function() {
            if (this.intervals) return this.intervals;
            this.intervals = [];
            for (var e = this.floor(this.min); e <= this.ceil(this.max); e += this.span(e)) {
                this.intervals.push({
                    human: c.dateStr(e, this.maxInterval),
                    timestamp: e
                })
            }
            return this.intervals
        }
    };
    var h = function(e, t) {
        var n = Array.prototype.slice.call(arguments, 2);
        _.each(n, function(n) {
            e.bind(n, function() {
                t[n].apply(t, arguments)
            })
        })
    };
    var p = function(e) {
        return parseInt(e.replace(/^[^+\-\d]?([+\-]?\d+)?.*$/, "$1"), 10)
    };
    var d = function(e) {
        return (e < 10 ? "0" : "") + e
    };
    var v = /^#*/;
    var m = {
        get: function() {
            return window.location.hash.replace(v, "")
        },
        set: function(e) {
            window.location.hash = e
        }
    };
    var g = 1;
    var y = function() {
        var e;
        if (g < 10) {
            e = g;
            g += 1
        } else {
            e = "default"
        }
        return e
    };
    var b = n.Timeline = function(e, t) {
        _.bindAll(this, "render", "setCurrentTimeline");
        this.data = e.sort(function(e, t) {
            return e.timestamp - t.timestamp
        });
        this.bySid = {};
        this.cards = [];
        this.series = [];
        this.config = t;
        this.config.container = this.config.container || "#timeline";
        c.formatter = this.config.formatter || function(e, t) {
            return t
        }
    };
    r(b.prototype);
    b.prototype = _.extend(b.prototype, {
        render: function() {
            var t = this;
            s(this, this.config.container);
            e(this.config.container).html(JST.timeline());
            this.bounds = new l;
            this.bar = new w(this);
            this.cardCont = new E(this);
            this.createSeries(this.data);
            var n = new c(this.bounds, this.config.interval);
            this.intervals = n.getRanges();
            this.bounds.extend(this.bounds.min - n.getMaxInterval() / 2);
            this.bounds.extend(this.bounds.max + n.getMaxInterval() / 2);
            this.bar.render();
            h(this.bar, this.cardCont, "move", "zoom");
            this.trigger("render");
            new L("in", this);
            new L("out", this);
            this.chooseNext = new A("next", this);
            this.choosePrev = new A("prev", this);
            if (!this.$(".TS-card_active").is("*")) this.chooseNext.click();
            e(this.config.container).bind("click", this.setCurrentTimeline);
            this.trigger("load")
        },
        setCurrentTimeline: function() {
            n.currentTimeline = this
        },
        createSeries: function(e) {
            for (var t = 0; t < e.length; t++) this.add(e[t])
        },
        add: function(e) {
            if (!(e.series in this.bySid)) {
                this.bySid[e.series] = new S(e, this);
                this.series.push(this.bySid[e.series])
            }
            var t = this.bySid[e.series];
            var n = t.add(e);
            this.bounds.extend(t.max());
            this.bounds.extend(t.min());
            this.trigger("cardAdd", e, n)
        }
    });
    var w = function(e) {
        var t = this;
        this.timeline = e;
        this.el = this.timeline.$(".TS-notchbar");
        this.el.css({
            left: 0
        });
        u(this);
        f(this);
        _.bindAll(this, "moving", "doZoom");
        this.el.bind("dragging scrolled", this.moving);
        this.el.bind("doZoom", this.doZoom);
        this.el.bind("dblclick doubletap", function(e) {
            e.preventDefault();
            t.timeline.$(".TS-zoom_in").click()
        })
    };
    r(w.prototype);
    i(w.prototype);
    w.prototype = _.extend(w.prototype, {
        moving: function(e) {
            var t = this.el.parent();
            var n = t.offset().left;
            var r = this.el.offset().left;
            var i = this.el.width();
            if (_.isUndefined(e.deltaX)) e.deltaX = 0;
            if (r + i + e.deltaX < n + t.width()) e.deltaX = n + t.width() - (r + i);
            if (r + e.deltaX > n) e.deltaX = n - r;
            this.trigger("move", e);
            this.timeline.trigger("move", e);
            this.move("move", e)
        },
        doZoom: function(t, n) {
            var r = this;
            var i = this.timeline.$(".TS-notch_active");
            var s = function() {
                return i.length > 0 ? i.position().left : 0
            };
            var o = s();
            this.el.animate({
                width: n + "%"
            }, {
                step: function(t, n) {
                    var i = e.Event("dragging");
                    var u = o - s();
                    i.deltaX = u;
                    r.moving(i);
                    o = s();
                    i = e.Event("zoom");
                    i.width = t + "%";
                    r.trigger("zoom", i)
                }
            })
        },
        render: function() {
            var t = this.timeline.intervals;
            var n = this.timeline.bounds;
            for (var r = 0; r < t.length; r++) {
                var i = JST.year_notch({
                    timestamp: t[r].timestamp,
                    human: t[r].human
                });
                this.el.append(e(i).css("left", n.project(t[r].timestamp, 100) + "%"))
            }
        }
    });
    var E = function(e) {
        this.el = e.$(".TS-card_scroller_inner")
    };
    r(E.prototype);
    i(E.prototype);
    var S = function(e, t) {
        this.timeline = t;
        this.name = e.series;
        this.color = this.name.length > 0 ? y() : "default";
        this.cards = [];
        _.bindAll(this, "render", "showNotches", "hideNotches");
        this.timeline.bind("render", this.render)
    };
    r(S.prototype);
    S.prototype = _.extend(S.prototype, {
        add: function(e) {
            var t = new x(e, this);
            this.cards.push(t);
            return t
        },
        _comparator: function(e) {
            return e.timestamp
        },
        hideNotches: function(e) {
            if (e) e.preventDefault();
            this.el.addClass("TS-series_legend_item_inactive");
            this.trigger("hideNotch")
        },
        showNotches: function(e) {
            if (e) e.preventDefault();
            this.el.removeClass("TS-series_legend_item_inactive");
            this.trigger("showNotch")
        },
        render: function(t) {
            if (this.name.length === 0) return;
            this.el = e(JST.series_legend(this));
            this.timeline.$(".TS-series_nav_container").append(this.el);
            var n = 0,
                r = this;
            this.el.on("click", function() {
                n++;
                if (n % 2) r.hideNotches();
                else r.showNotches()
            })
        }
    });
    _(["min", "max"]).each(function(e) {
        S.prototype[e] = function() {
            return _[e].call(_, this.cards, this._comparator).get("timestamp")
        }
    });
    var x = function(e, t) {
        this.series = t;
        this.timeline = this.series.timeline;
        e = _.clone(e);
        this.timestamp = e.timestamp;
        this.attributes = e;
        this.attributes.topcolor = t.color;
        _.bindAll(this, "render", "activate", "flip", "setPermalink", "toggleNotch");
        this.series.bind("hideNotch", this.toggleNotch);
        this.series.bind("showNotch", this.toggleNotch);
        this.timeline.bind("render", this.render);
        this.timeline.bar.bind("move", this.flip);
        this.id = [this.get("timestamp"), this.get("description").split(/ /)[0].replace(/[^a-zA-Z\-]/g, "")].join("-");
        this.timeline.cards.push(this);
        this.template = window.JST.card
    };
    x.prototype = _.extend(x.prototype, {
        get: function(e) {
            return this.attributes[e]
        },
        render: function() {
            this.offset = this.timeline.bounds.project(this.timestamp, 100);
            var t = JST.notch(this.attributes);
            this.notch = e(t).css({
                left: this.offset + "%"
            });
            this.timeline.$(".TS-notchbar").append(this.notch);
            this.notch.click(this.activate);
            if (m.get() === this.id) this.activate()
        },
        flip: function() {
            if (!this.el || !this.el.is(":visible")) return;
            var e = this.$(".TS-item").offset().left + this.$(".TS-item").width();
            var t = this.timeline.$(".timeline_setter").offset().left + this.timeline.$(".timeline_setter").width();
            var n = this.el.css("margin-left") === this.originalMargin;
            var r = this.$(".TS-item").width() < this.timeline.$(".timeline_setter").width() / 2;
            var i = this.el.offset().left - this.el.parent().offset().left - this.$(".TS-item").width() < 0;
            if (t - e < 0 && n && !i) {
                this.el.css({
                    "margin-left": -(this.$(".TS-item").width() + 7)
                });
                this.$(".TS-css_arrow").css({
                    left: this.$(".TS-item").width()
                })
            } else if (this.el.offset().left - this.timeline.$(".timeline_setter").offset().left < 0 && !n && r) {
                this.el.css({
                    "margin-left": this.originalMargin
                });
                this.$(".TS-css_arrow").css({
                    left: 0
                })
            }
        },
        activate: function(t) {
            var n = this;
            this.hideActiveCard();
            if (!this.el) {
                this.el = e(this.template({
                    card: this
                }));
                s(this, this.el);
                this.el.css({
                    left: this.offset + "%"
                });
                this.timeline.$(".TS-card_scroller_inner").append(this.el);
                this.originalMargin = this.el.css("margin-left");
                this.el.delegate(".TS-permalink", "click", this.setPermalink);
                this.timeline.$("img").load(this.activate)
            }
            this.el.show().addClass("TS-card_active");
            this.notch.addClass("TS-notch_active");
            this.setWidth();
            this.flip();
            this.move();
            this.series.timeline.trigger("cardActivate", this.attributes)
        },
        setWidth: function() {
            var e = this;
            var t = _.max(_.toArray(this.$(".TS-item_user_html").children()), function(t) {
                return e.$(t).width()
            });
            if (this.$(t).width() > this.$(".TS-item_year").width()) {
                this.$(".TS-item_label").css("width", this.$(t).width())
            } else {
                this.$(".TS-item_label").css("width", this.$(".TS-item_year").width())
            }
        },
        move: function() {
            var t = e.Event("moving");
            var n = this.$(".TS-item").offset();
            var r = this.timeline.$(".timeline_setter").offset();
            if (n.left < r.left) {
                t.deltaX = r.left - n.left + p(this.$(".TS-item").css("padding-left"));
                this.timeline.bar.moving(t)
            } else if (n.left + this.$(".TS-item").outerWidth() > r.left + this.timeline.$(".timeline_setter").width()) {
                t.deltaX = r.left + this.timeline.$(".timeline_setter").width() - (n.left + this.$(".TS-item").outerWidth());
                this.timeline.bar.moving(t)
            }
        },
        setPermalink: function() {
            m.set(this.id)
        },
        hideActiveCard: function() {
            this.timeline.$(".TS-card_active").removeClass("TS-card_active").hide();
            this.timeline.$(".TS-notch_active").removeClass("TS-notch_active")
        },
        toggleNotch: function(e) {
            switch (e) {
                case "hideNotch":
                    this.notch.hide().removeClass("TS-notch_active").addClass("TS-series_inactive");
                    if (this.el) this.el.hide();
                    return;
                case "showNotch":
                    this.notch.removeClass("TS-series_inactive").show()
            }
        }
    });
    var T = function() {};
    var N = function(e, t) {
        T.prototype = t.prototype;
        e.prototype = new T;
        e.prototype.constructor = e
    };
    var C = function(e, t) {
        this.timeline = t;
        this.direction = e;
        this.el = this.timeline.$(this.prefix + e);
        var n = this;
        this.el.bind("click", function(e) {
            e.preventDefault();
            n.click(e)
        })
    };
    var k = 100;
    var L = function(e, t) {
        C.apply(this, arguments)
    };
    N(L, C);
    L.prototype = _.extend(L.prototype, {
        prefix: ".TS-zoom_",
        click: function() {
            k += this.direction === "in" ? +100 : -100;
            if (k >= 100) {
                this.timeline.$(".TS-notchbar").trigger("doZoom", [k])
            } else {
                k = 100
            }
        }
    });
    var A = function(e, t) {
        C.apply(this, arguments);
        this.notches = this.timeline.$(".TS-notch")
    };
    N(A, C);
    A.prototype = _.extend(C.prototype, {
        prefix: ".TS-choose_",
        click: function(e) {
            var t;
            var n = this.notches.not(".TS-series_inactive");
            var r = n.index(this.timeline.$(".TS-notch_active"));
            var i = n.length;
            if (this.direction === "next") {
                t = r < i ? n.eq(r + 1) : false
            } else {
                t = r > 0 ? n.eq(r - 1) : false
            } if (!t) return;
            t.trigger("click")
        }
    });
    n.Api = function(e) {
        this.timeline = e
    };
    n.Api.prototype = _.extend(n.Api.prototype, {
        onLoad: function(e) {
            this.timeline.bind("load", e)
        },
        onCardAdd: function(e) {
            this.timeline.bind("cardAdd", e)
        },
        onCardActivate: function(e) {
            this.timeline.bind("cardActivate", e)
        },
        onBarMove: function(e) {
            this.timeline.bind("move", e)
        },
        activateCard: function(e) {
            _(this.timeline.cards).detect(function(t) {
                return t.timestamp === e
            }).activate()
        }
    });
    n.bindKeydowns = function() {
        e(document).bind("keydown", function(e) {
            if (e.keyCode === 39) {
                n.currentTimeline.chooseNext.click()
            } else if (e.keyCode === 37) {
                n.currentTimeline.choosePrev.click()
            } else {
                return
            }
        })
    };
    b.boot = function(t, r) {
        var i = n.timeline = new b(t, r || {});
        var s = new n.Api(i);
        if (!n.pageTimelines) {
            n.currentTimeline = i;
            n.bindKeydowns()
        }
        n.pageTimelines = n.pageTimelines ? n.pageTimelines += 1 : 1;
        e(i.render);
        return {
            timeline: i,
            api: s
        }
    }
})(jQuery);
(function() {
    window.JST = window.JST || {};
    var e = function(e) {
        var t = new Function("obj", "var __p=[],print=function(){__p.push.apply(__p,arguments);};with(obj||{}){__p.push('" + e.replace(/\\/g, "\\\\").replace(/'/g, "\\'").replace(/<%=([\s\S]+?)%>/g, function(e, t) {
            return "'," + t.replace(/\\'/g, "'") + ",'"
        }).replace(/<%([\s\S]+?)%>/g, function(e, t) {
            return "');" + t.replace(/\\'/g, "'").replace(/[\r\n\t]/g, " ") + "__p.push('"
        }).replace(/\r/g, "\\r").replace(/\n/g, "\\n").replace(/\t/g, "\\t") + "');}return __p.join('');");
        return t
    };
    window.JST.card = e('<div class="TS-card_container TS-card_container_<%= (card.get("series") || "").replace(/W/g, "") %>">\n<div class="TS-css_arrow TS-css_arrow_up TS-css_arrow_color_<%= card.get("topcolor") %>"></div>\n  <div class="TS-item TS-item_color_<%= card.get("topcolor") %>" data-timestamp="<%= card.get("timestamp") %>">\n    <div class="TS-item_label">\n      <% if (!_.isEmpty(card.get("html"))){ %>\n        <div class="TS-item_user_html">\n          <%= card.get("html") %>\n        </div>\n      <% } %>\n      <%= card.get("description") %>\n    </div>\n      <% if (!_.isEmpty(card.get("link"))){ %>\n          <a class="TS-read_btn" target="_blank" href="<%= card.get("link") %>">Read More</a>\n      <% } %>\n\n    <div class="TS-item_year">\n      <span class="TS-item_year_text"><%= (card.get("display_date") || "").length > 0 ? card.get("display_date") : card.get("date") %></span>\n      <div class="TS-permalink">&#8734;</div>\n    </div>\n  </div>\n</div>');
    window.JST.notch = e('<div class="TS-notch TS-notch_<%= timestamp %> TS-notch_<%= series.replace(/W/g, "") %> TS-notch_color_<%= topcolor %>"></div>\n');
    window.JST.series_legend = e('<div class="TS-series_legend_item TS-series_legend_item_<%= name.replace(/W/g, "") %>">\n  <span class="TS-series_legend_swatch TS-series_legend_swatch_<%= color %>">&nbsp;</span> <span class="TS-series_legend_text"><%= name %></span>\n</div>\n');
    window.JST.timeline = e('<div class="timeline_setter">\n  <div class="TS-top_matter_container">\n    <div class="TS-controls">\n      <div class="TS-zoom-container">\n        <a href="#" class="TS-zoom TS-zoom_in"><span class="TS-controls_inner_text TS-zoom_inner_text">+</span></a> \n        <a href="#" class="TS-zoom TS-zoom_out"><span class="TS-controls_inner_text TS-zoom_inner_text">-</span></a>\n      </div> \n      <div class="TS-choose-container">\n        <a href="#" class="TS-choose TS-choose_prev">&laquo;&nbsp;<span class="TS-controls_inner_text">Zpět</span></a> \n        <a href="#" class="TS-choose TS-choose_next"><span class="TS-controls_inner_text">Dál</span>&nbsp;&raquo;</a>\n      </div>\n    </div>\n    <div class="TS-series_nav_container"></div>\n  </div>\n\n  <div class="TS-notchbar_container">\n    <div class="TS-notchbar"></div>\n  </div>\n  <div class="TS-card_scroller">\n    <div class="TS-card_scroller_inner">\n    </div>\n  </div>\n</div>');
    window.JST.year_notch = e('<div class="TS-year_notch TS-year_notch_<%= timestamp %>">\n  <span class="TS-year_notch_year_text"><%= human %></span>\n</div>\n')
})()