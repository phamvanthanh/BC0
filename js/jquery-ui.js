/*! jQuery UI - v1.10.3 Custom - 2013-10-28
 * http://jqueryui.com
 * Includes: jquery.ui.widget.js, jquery.ui.effect.js
 * Copyright 2013 jQuery Foundation and other contributors; Licensed MIT */
! function(t, e) {
    var n = 0,
        r = Array.prototype.slice,
        i = t.cleanData;
    t.cleanData = function(e) {
        for (var n, r = 0; null != (n = e[r]); r++) try {
            t(n).triggerHandler("remove")
        } catch (s) {}
        i(e)
    }, t.widget = function(n, r, i) {
        var s, o, a, u, c = {},
            l = n.split(".")[0];
        n = n.split(".")[1], s = l + "-" + n, i || (i = r, r = t.Widget), t.expr[":"][s.toLowerCase()] = function(e) {
            return !!t.data(e, s)
        }, t[l] = t[l] || {}, o = t[l][n], a = t[l][n] = function(t, n) {
            return this._createWidget ? (arguments.length && this._createWidget(t, n), e) : new a(t, n)
        }, t.extend(a, o, {
            version: i.version,
            _proto: t.extend({}, i),
            _childConstructors: []
        }), u = new r, u.options = t.widget.extend({}, u.options), t.each(i, function(n, i) {
            return t.isFunction(i) ? (c[n] = function() {
                var t = function() {
                        return r.prototype[n].apply(this, arguments)
                    },
                    e = function(t) {
                        return r.prototype[n].apply(this, t)
                    };
                return function() {
                    var n, r = this._super,
                        s = this._superApply;
                    return this._super = t, this._superApply = e, n = i.apply(this, arguments), this._super = r, this._superApply = s, n
                }
            }(), e) : (c[n] = i, e)
        }), a.prototype = t.widget.extend(u, {
            widgetEventPrefix: o ? u.widgetEventPrefix : n
        }, c, {
            constructor: a,
            namespace: l,
            widgetName: n,
            widgetFullName: s
        }), o ? (t.each(o._childConstructors, function(e, n) {
            var r = n.prototype;
            t.widget(r.namespace + "." + r.widgetName, a, n._proto)
        }), delete o._childConstructors) : r._childConstructors.push(a), t.widget.bridge(n, a)
    }, t.widget.extend = function(n) {
        for (var i, s, o = r.call(arguments, 1), a = 0, u = o.length; u > a; a++)
            for (i in o[a]) s = o[a][i], o[a].hasOwnProperty(i) && s !== e && (n[i] = t.isPlainObject(s) ? t.isPlainObject(n[i]) ? t.widget.extend({}, n[i], s) : t.widget.extend({}, s) : s);
        return n
    }, t.widget.bridge = function(n, i) {
        var s = i.prototype.widgetFullName || n;
        t.fn[n] = function(o) {
            var a = "string" == typeof o,
                u = r.call(arguments, 1),
                c = this;
            return o = !a && u.length ? t.widget.extend.apply(null, [o].concat(u)) : o, a ? this.each(function() {
                var r, i = t.data(this, s);
                return i ? t.isFunction(i[o]) && "_" !== o.charAt(0) ? (r = i[o].apply(i, u), r !== i && r !== e ? (c = r && r.jquery ? c.pushStack(r.get()) : r, !1) : e) : t.error("no such method '" + o + "' for " + n + " widget instance") : t.error("cannot call methods on " + n + " prior to initialization; attempted to call method '" + o + "'")
            }) : this.each(function() {
                var e = t.data(this, s);
                e ? e.option(o || {})._init() : t.data(this, s, new i(o, this))
            }), c
        }
    }, t.Widget = function() {}, t.Widget._childConstructors = [], t.Widget.prototype = {
        widgetName: "widget",
        widgetEventPrefix: "",
        defaultElement: "<div>",
        options: {
            disabled: !1,
            create: null
        },
        _createWidget: function(e, r) {
            r = t(r || this.defaultElement || this)[0], this.element = t(r), this.uuid = n++, this.eventNamespace = "." + this.widgetName + this.uuid, this.options = t.widget.extend({}, this.options, this._getCreateOptions(), e), this.bindings = t(), this.hoverable = t(), this.focusable = t(), r !== this && (t.data(r, this.widgetFullName, this), this._on(!0, this.element, {
                remove: function(t) {
                    t.target === r && this.destroy()
                }
            }), this.document = t(r.style ? r.ownerDocument : r.document || r), this.window = t(this.document[0].defaultView || this.document[0].parentWindow)), this._create(), this._trigger("create", null, this._getCreateEventData()), this._init()
        },
        _getCreateOptions: t.noop,
        _getCreateEventData: t.noop,
        _create: t.noop,
        _init: t.noop,
        destroy: function() {
            this._destroy(), this.element.unbind(this.eventNamespace).removeData(this.widgetName).removeData(this.widgetFullName).removeData(t.camelCase(this.widgetFullName)), this.widget().unbind(this.eventNamespace).removeAttr("aria-disabled").removeClass(this.widgetFullName + "-disabled ui-state-disabled"), this.bindings.unbind(this.eventNamespace), this.hoverable.removeClass("ui-state-hover"), this.focusable.removeClass("ui-state-focus")
        },
        _destroy: t.noop,
        widget: function() {
            return this.element
        },
        option: function(n, r) {
            var i, s, o, a = n;
            if (0 === arguments.length) return t.widget.extend({}, this.options);
            if ("string" == typeof n)
                if (a = {}, i = n.split("."), n = i.shift(), i.length) {
                    for (s = a[n] = t.widget.extend({}, this.options[n]), o = 0; i.length - 1 > o; o++) s[i[o]] = s[i[o]] || {}, s = s[i[o]];
                    if (n = i.pop(), r === e) return s[n] === e ? null : s[n];
                    s[n] = r
                } else {
                    if (r === e) return this.options[n] === e ? null : this.options[n];
                    a[n] = r
                }
            return this._setOptions(a), this
        },
        _setOptions: function(t) {
            var e;
            for (e in t) this._setOption(e, t[e]);
            return this
        },
        _setOption: function(t, e) {
            return this.options[t] = e, "disabled" === t && (this.widget().toggleClass(this.widgetFullName + "-disabled ui-state-disabled", !!e).attr("aria-disabled", e), this.hoverable.removeClass("ui-state-hover"), this.focusable.removeClass("ui-state-focus")), this
        },
        enable: function() {
            return this._setOption("disabled", !1)
        },
        disable: function() {
            return this._setOption("disabled", !0)
        },
        _on: function(n, r, i) {
            var s, o = this;
            "boolean" != typeof n && (i = r, r = n, n = !1), i ? (r = s = t(r), this.bindings = this.bindings.add(r)) : (i = r, r = this.element, s = this.widget()), t.each(i, function(i, a) {
                function u() {
                    return n || o.options.disabled !== !0 && !t(this).hasClass("ui-state-disabled") ? ("string" == typeof a ? o[a] : a).apply(o, arguments) : e
                }
                "string" != typeof a && (u.guid = a.guid = a.guid || u.guid || t.guid++);
                var c = i.match(/^(\w+)\s*(.*)$/),
                    l = c[1] + o.eventNamespace,
                    f = c[2];
                f ? s.delegate(f, l, u) : r.bind(l, u)
            })
        },
        _off: function(t, e) {
            e = (e || "").split(" ").join(this.eventNamespace + " ") + this.eventNamespace, t.unbind(e).undelegate(e)
        },
        _delay: function(t, e) {
            function n() {
                return ("string" == typeof t ? r[t] : t).apply(r, arguments)
            }
            var r = this;
            return setTimeout(n, e || 0)
        },
        _hoverable: function(e) {
            this.hoverable = this.hoverable.add(e), this._on(e, {
                mouseenter: function(e) {
                    t(e.currentTarget).addClass("ui-state-hover")
                },
                mouseleave: function(e) {
                    t(e.currentTarget).removeClass("ui-state-hover")
                }
            })
        },
        _focusable: function(e) {
            this.focusable = this.focusable.add(e), this._on(e, {
                focusin: function(e) {
                    t(e.currentTarget).addClass("ui-state-focus")
                },
                focusout: function(e) {
                    t(e.currentTarget).removeClass("ui-state-focus")
                }
            })
        },
        _trigger: function(e, n, r) {
            var i, s, o = this.options[e];
            if (r = r || {}, n = t.Event(n), n.type = (e === this.widgetEventPrefix ? e : this.widgetEventPrefix + e).toLowerCase(), n.target = this.element[0], s = n.originalEvent)
                for (i in s) i in n || (n[i] = s[i]);
            return this.element.trigger(n, r), !(t.isFunction(o) && o.apply(this.element[0], [n].concat(r)) === !1 || n.isDefaultPrevented())
        }
    }, t.each({
        show: "fadeIn",
        hide: "fadeOut"
    }, function(e, n) {
        t.Widget.prototype["_" + e] = function(r, i, s) {
            "string" == typeof i && (i = {
                effect: i
            });
            var o, a = i ? i === !0 || "number" == typeof i ? n : i.effect || n : e;
            i = i || {}, "number" == typeof i && (i = {
                duration: i
            }), o = !t.isEmptyObject(i), i.complete = s, i.delay && r.delay(i.delay), o && t.effects && t.effects.effect[a] ? r[e](i) : a !== e && r[a] ? r[a](i.duration, i.easing, s) : r.queue(function(n) {
                t(this)[e](), s && s.call(r[0]), n()
            })
        }
    })
}(jQuery),
function(t, e) {
    var n = "ui-effects-";
    t.effects = {
            effect: {}
        },
        function(t, e) {
            function n(t, e, n) {
                var r = f[e.type] || {};
                return null == t ? n || !e.def ? null : e.def : (t = r.floor ? ~~t : parseFloat(t), isNaN(t) ? e.def : r.mod ? (t + r.mod) % r.mod : 0 > t ? 0 : t > r.max ? r.max : t)
            }

            function r(n) {
                var r = c(),
                    i = r._rgba = [];
                return n = n.toLowerCase(), p(u, function(t, s) {
                    var o, a = s.re.exec(n),
                        u = a && s.parse(a),
                        c = s.space || "rgba";
                    return u ? (o = r[c](u), r[l[c].cache] = o[l[c].cache], i = r._rgba = o._rgba, !1) : e
                }), i.length ? ("0,0,0,0" === i.join() && t.extend(i, s.transparent), r) : s[n]
            }

            function i(t, e, n) {
                return n = (n + 1) % 1, 1 > 6 * n ? t + 6 * (e - t) * n : 1 > 2 * n ? e : 2 > 3 * n ? t + 6 * (e - t) * (2 / 3 - n) : t
            }
            var s, o = "backgroundColor borderBottomColor borderLeftColor borderRightColor borderTopColor color columnRuleColor outlineColor textDecorationColor textEmphasisColor",
                a = /^([\-+])=\s*(\d+\.?\d*)/,
                u = [{
                    re: /rgba?\(\s*(\d{1,3})\s*,\s*(\d{1,3})\s*,\s*(\d{1,3})\s*(?:,\s*(\d?(?:\.\d+)?)\s*)?\)/,
                    parse: function(t) {
                        return [t[1], t[2], t[3], t[4]]
                    }
                }, {
                    re: /rgba?\(\s*(\d+(?:\.\d+)?)\%\s*,\s*(\d+(?:\.\d+)?)\%\s*,\s*(\d+(?:\.\d+)?)\%\s*(?:,\s*(\d?(?:\.\d+)?)\s*)?\)/,
                    parse: function(t) {
                        return [2.55 * t[1], 2.55 * t[2], 2.55 * t[3], t[4]]
                    }
                }, {
                    re: /#([a-f0-9]{2})([a-f0-9]{2})([a-f0-9]{2})/,
                    parse: function(t) {
                        return [parseInt(t[1], 16), parseInt(t[2], 16), parseInt(t[3], 16)]
                    }
                }, {
                    re: /#([a-f0-9])([a-f0-9])([a-f0-9])/,
                    parse: function(t) {
                        return [parseInt(t[1] + t[1], 16), parseInt(t[2] + t[2], 16), parseInt(t[3] + t[3], 16)]
                    }
                }, {
                    re: /hsla?\(\s*(\d+(?:\.\d+)?)\s*,\s*(\d+(?:\.\d+)?)\%\s*,\s*(\d+(?:\.\d+)?)\%\s*(?:,\s*(\d?(?:\.\d+)?)\s*)?\)/,
                    space: "hsla",
                    parse: function(t) {
                        return [t[1], t[2] / 100, t[3] / 100, t[4]]
                    }
                }],
                c = t.Color = function(e, n, r, i) {
                    return new t.Color.fn.parse(e, n, r, i)
                },
                l = {
                    rgba: {
                        props: {
                            red: {
                                idx: 0,
                                type: "byte"
                            },
                            green: {
                                idx: 1,
                                type: "byte"
                            },
                            blue: {
                                idx: 2,
                                type: "byte"
                            }
                        }
                    },
                    hsla: {
                        props: {
                            hue: {
                                idx: 0,
                                type: "degrees"
                            },
                            saturation: {
                                idx: 1,
                                type: "percent"
                            },
                            lightness: {
                                idx: 2,
                                type: "percent"
                            }
                        }
                    }
                },
                f = {
                    "byte": {
                        floor: !0,
                        max: 255
                    },
                    percent: {
                        max: 1
                    },
                    degrees: {
                        mod: 360,
                        floor: !0
                    }
                },
                d = c.support = {},
                h = t("<p>")[0],
                p = t.each;
            h.style.cssText = "background-color:rgba(1,1,1,.5)", d.rgba = h.style.backgroundColor.indexOf("rgba") > -1, p(l, function(t, e) {
                e.cache = "_" + t, e.props.alpha = {
                    idx: 3,
                    type: "percent",
                    def: 1
                }
            }), c.fn = t.extend(c.prototype, {
                parse: function(i, o, a, u) {
                    if (i === e) return this._rgba = [null, null, null, null], this;
                    (i.jquery || i.nodeType) && (i = t(i).css(o), o = e);
                    var f = this,
                        d = t.type(i),
                        h = this._rgba = [];
                    return o !== e && (i = [i, o, a, u], d = "array"), "string" === d ? this.parse(r(i) || s._default) : "array" === d ? (p(l.rgba.props, function(t, e) {
                        h[e.idx] = n(i[e.idx], e)
                    }), this) : "object" === d ? (i instanceof c ? p(l, function(t, e) {
                        i[e.cache] && (f[e.cache] = i[e.cache].slice())
                    }) : p(l, function(e, r) {
                        var s = r.cache;
                        p(r.props, function(t, e) {
                            if (!f[s] && r.to) {
                                if ("alpha" === t || null == i[t]) return;
                                f[s] = r.to(f._rgba)
                            }
                            f[s][e.idx] = n(i[t], e, !0)
                        }), f[s] && 0 > t.inArray(null, f[s].slice(0, 3)) && (f[s][3] = 1, r.from && (f._rgba = r.from(f[s])))
                    }), this) : e
                },
                is: function(t) {
                    var n = c(t),
                        r = !0,
                        i = this;
                    return p(l, function(t, s) {
                        var o, a = n[s.cache];
                        return a && (o = i[s.cache] || s.to && s.to(i._rgba) || [], p(s.props, function(t, n) {
                            return null != a[n.idx] ? r = a[n.idx] === o[n.idx] : e
                        })), r
                    }), r
                },
                _space: function() {
                    var t = [],
                        e = this;
                    return p(l, function(n, r) {
                        e[r.cache] && t.push(n)
                    }), t.pop()
                },
                transition: function(t, e) {
                    var r = c(t),
                        i = r._space(),
                        s = l[i],
                        o = 0 === this.alpha() ? c("transparent") : this,
                        a = o[s.cache] || s.to(o._rgba),
                        u = a.slice();
                    return r = r[s.cache], p(s.props, function(t, i) {
                        var s = i.idx,
                            o = a[s],
                            c = r[s],
                            l = f[i.type] || {};
                        null !== c && (null === o ? u[s] = c : (l.mod && (c - o > l.mod / 2 ? o += l.mod : o - c > l.mod / 2 && (o -= l.mod)), u[s] = n((c - o) * e + o, i)))
                    }), this[i](u)
                },
                blend: function(e) {
                    if (1 === this._rgba[3]) return this;
                    var n = this._rgba.slice(),
                        r = n.pop(),
                        i = c(e)._rgba;
                    return c(t.map(n, function(t, e) {
                        return (1 - r) * i[e] + r * t
                    }))
                },
                toRgbaString: function() {
                    var e = "rgba(",
                        n = t.map(this._rgba, function(t, e) {
                            return null == t ? e > 2 ? 1 : 0 : t
                        });
                    return 1 === n[3] && (n.pop(), e = "rgb("), e + n.join() + ")"
                },
                toHslaString: function() {
                    var e = "hsla(",
                        n = t.map(this.hsla(), function(t, e) {
                            return null == t && (t = e > 2 ? 1 : 0), e && 3 > e && (t = Math.round(100 * t) + "%"), t
                        });
                    return 1 === n[3] && (n.pop(), e = "hsl("), e + n.join() + ")"
                },
                toHexString: function(e) {
                    var n = this._rgba.slice(),
                        r = n.pop();
                    return e && n.push(~~(255 * r)), "#" + t.map(n, function(t) {
                        return t = (t || 0).toString(16), 1 === t.length ? "0" + t : t
                    }).join("")
                },
                toString: function() {
                    return 0 === this._rgba[3] ? "transparent" : this.toRgbaString()
                }
            }), c.fn.parse.prototype = c.fn, l.hsla.to = function(t) {
                if (null == t[0] || null == t[1] || null == t[2]) return [null, null, null, t[3]];
                var e, n, r = t[0] / 255,
                    i = t[1] / 255,
                    s = t[2] / 255,
                    o = t[3],
                    a = Math.max(r, i, s),
                    u = Math.min(r, i, s),
                    c = a - u,
                    l = a + u,
                    f = .5 * l;
                return e = u === a ? 0 : r === a ? 60 * (i - s) / c + 360 : i === a ? 60 * (s - r) / c + 120 : 60 * (r - i) / c + 240, n = 0 === c ? 0 : .5 >= f ? c / l : c / (2 - l), [Math.round(e) % 360, n, f, null == o ? 1 : o]
            }, l.hsla.from = function(t) {
                if (null == t[0] || null == t[1] || null == t[2]) return [null, null, null, t[3]];
                var e = t[0] / 360,
                    n = t[1],
                    r = t[2],
                    s = t[3],
                    o = .5 >= r ? r * (1 + n) : r + n - r * n,
                    a = 2 * r - o;
                return [Math.round(255 * i(a, o, e + 1 / 3)), Math.round(255 * i(a, o, e)), Math.round(255 * i(a, o, e - 1 / 3)), s]
            }, p(l, function(r, i) {
                var s = i.props,
                    o = i.cache,
                    u = i.to,
                    l = i.from;
                c.fn[r] = function(r) {
                    if (u && !this[o] && (this[o] = u(this._rgba)), r === e) return this[o].slice();
                    var i, a = t.type(r),
                        f = "array" === a || "object" === a ? r : arguments,
                        d = this[o].slice();
                    return p(s, function(t, e) {
                        var r = f["object" === a ? t : e.idx];
                        null == r && (r = d[e.idx]), d[e.idx] = n(r, e)
                    }), l ? (i = c(l(d)), i[o] = d, i) : c(d)
                }, p(s, function(e, n) {
                    c.fn[e] || (c.fn[e] = function(i) {
                        var s, o = t.type(i),
                            u = "alpha" === e ? this._hsla ? "hsla" : "rgba" : r,
                            c = this[u](),
                            l = c[n.idx];
                        return "undefined" === o ? l : ("function" === o && (i = i.call(this, l), o = t.type(i)), null == i && n.empty ? this : ("string" === o && (s = a.exec(i), s && (i = l + parseFloat(s[2]) * ("+" === s[1] ? 1 : -1))), c[n.idx] = i, this[u](c)))
                    })
                })
            }), c.hook = function(e) {
                var n = e.split(" ");
                p(n, function(e, n) {
                    t.cssHooks[n] = {
                        set: function(e, i) {
                            var s, o, a = "";
                            if ("transparent" !== i && ("string" !== t.type(i) || (s = r(i)))) {
                                if (i = c(s || i), !d.rgba && 1 !== i._rgba[3]) {
                                    for (o = "backgroundColor" === n ? e.parentNode : e;
                                        ("" === a || "transparent" === a) && o && o.style;) try {
                                        a = t.css(o, "backgroundColor"), o = o.parentNode
                                    } catch (u) {}
                                    i = i.blend(a && "transparent" !== a ? a : "_default")
                                }
                                i = i.toRgbaString()
                            }
                            try {
                                e.style[n] = i
                            } catch (u) {}
                        }
                    }, t.fx.step[n] = function(e) {
                        e.colorInit || (e.start = c(e.elem, n), e.end = c(e.end), e.colorInit = !0), t.cssHooks[n].set(e.elem, e.start.transition(e.end, e.pos))
                    }
                })
            }, c.hook(o), t.cssHooks.borderColor = {
                expand: function(t) {
                    var e = {};
                    return p(["Top", "Right", "Bottom", "Left"], function(n, r) {
                        e["border" + r + "Color"] = t
                    }), e
                }
            }, s = t.Color.names = {
                aqua: "#00ffff",
                black: "#000000",
                blue: "#0000ff",
                fuchsia: "#ff00ff",
                gray: "#808080",
                green: "#008000",
                lime: "#00ff00",
                maroon: "#800000",
                navy: "#000080",
                olive: "#808000",
                purple: "#800080",
                red: "#ff0000",
                silver: "#c0c0c0",
                teal: "#008080",
                white: "#ffffff",
                yellow: "#ffff00",
                transparent: [null, null, null, 0],
                _default: "#ffffff"
            }
        }(jQuery),
        function() {
            function n(e) {
                var n, r, i = e.ownerDocument.defaultView ? e.ownerDocument.defaultView.getComputedStyle(e, null) : e.currentStyle,
                    s = {};
                if (i && i.length && i[0] && i[i[0]])
                    for (r = i.length; r--;) n = i[r], "string" == typeof i[n] && (s[t.camelCase(n)] = i[n]);
                else
                    for (n in i) "string" == typeof i[n] && (s[n] = i[n]);
                return s
            }

            function r(e, n) {
                var r, i, o = {};
                for (r in n) i = n[r], e[r] !== i && (s[r] || (t.fx.step[r] || !isNaN(parseFloat(i))) && (o[r] = i));
                return o
            }
            var i = ["add", "remove", "toggle"],
                s = {
                    border: 1,
                    borderBottom: 1,
                    borderColor: 1,
                    borderLeft: 1,
                    borderRight: 1,
                    borderTop: 1,
                    borderWidth: 1,
                    margin: 1,
                    padding: 1
                };
            t.each(["borderLeftStyle", "borderRightStyle", "borderBottomStyle", "borderTopStyle"], function(e, n) {
                t.fx.step[n] = function(t) {
                    ("none" !== t.end && !t.setAttr || 1 === t.pos && !t.setAttr) && (jQuery.style(t.elem, n, t.end), t.setAttr = !0)
                }
            }), t.fn.addBack || (t.fn.addBack = function(t) {
                return this.add(null == t ? this.prevObject : this.prevObject.filter(t))
            }), t.effects.animateClass = function(e, s, o, a) {
                var u = t.speed(s, o, a);
                return this.queue(function() {
                    var s, o = t(this),
                        a = o.attr("class") || "",
                        c = u.children ? o.find("*").addBack() : o;
                    c = c.map(function() {
                        var e = t(this);
                        return {
                            el: e,
                            start: n(this)
                        }
                    }), s = function() {
                        t.each(i, function(t, n) {
                            e[n] && o[n + "Class"](e[n])
                        })
                    }, s(), c = c.map(function() {
                        return this.end = n(this.el[0]), this.diff = r(this.start, this.end), this
                    }), o.attr("class", a), c = c.map(function() {
                        var e = this,
                            n = t.Deferred(),
                            r = t.extend({}, u, {
                                queue: !1,
                                complete: function() {
                                    n.resolve(e)
                                }
                            });
                        return this.el.animate(this.diff, r), n.promise()
                    }), t.when.apply(t, c.get()).done(function() {
                        s(), t.each(arguments, function() {
                            var e = this.el;
                            t.each(this.diff, function(t) {
                                e.css(t, "")
                            })
                        }), u.complete.call(o[0])
                    })
                })
            }, t.fn.extend({
                addClass: function(e) {
                    return function(n, r, i, s) {
                        return r ? t.effects.animateClass.call(this, {
                            add: n
                        }, r, i, s) : e.apply(this, arguments)
                    }
                }(t.fn.addClass),
                removeClass: function(e) {
                    return function(n, r, i, s) {
                        return arguments.length > 1 ? t.effects.animateClass.call(this, {
                            remove: n
                        }, r, i, s) : e.apply(this, arguments)
                    }
                }(t.fn.removeClass),
                toggleClass: function(n) {
                    return function(r, i, s, o, a) {
                        return "boolean" == typeof i || i === e ? s ? t.effects.animateClass.call(this, i ? {
                            add: r
                        } : {
                            remove: r
                        }, s, o, a) : n.apply(this, arguments) : t.effects.animateClass.call(this, {
                            toggle: r
                        }, i, s, o)
                    }
                }(t.fn.toggleClass),
                switchClass: function(e, n, r, i, s) {
                    return t.effects.animateClass.call(this, {
                        add: n,
                        remove: e
                    }, r, i, s)
                }
            })
        }(),
        function() {
            function r(e, n, r, i) {
                return t.isPlainObject(e) && (n = e, e = e.effect), e = {
                    effect: e
                }, null == n && (n = {}), t.isFunction(n) && (i = n, r = null, n = {}), ("number" == typeof n || t.fx.speeds[n]) && (i = r, r = n, n = {}), t.isFunction(r) && (i = r, r = null), n && t.extend(e, n), r = r || n.duration, e.duration = t.fx.off ? 0 : "number" == typeof r ? r : r in t.fx.speeds ? t.fx.speeds[r] : t.fx.speeds._default, e.complete = i || n.complete, e
            }

            function i(e) {
                return !e || "number" == typeof e || t.fx.speeds[e] ? !0 : "string" != typeof e || t.effects.effect[e] ? t.isFunction(e) ? !0 : "object" != typeof e || e.effect ? !1 : !0 : !0
            }
            t.extend(t.effects, {
                version: "1.10.3",
                save: function(t, e) {
                    for (var r = 0; e.length > r; r++) null !== e[r] && t.data(n + e[r], t[0].style[e[r]])
                },
                restore: function(t, r) {
                    var i, s;
                    for (s = 0; r.length > s; s++) null !== r[s] && (i = t.data(n + r[s]), i === e && (i = ""), t.css(r[s], i))
                },
                setMode: function(t, e) {
                    return "toggle" === e && (e = t.is(":hidden") ? "show" : "hide"), e
                },
                getBaseline: function(t, e) {
                    var n, r;
                    switch (t[0]) {
                        case "top":
                            n = 0;
                            break;
                        case "middle":
                            n = .5;
                            break;
                        case "bottom":
                            n = 1;
                            break;
                        default:
                            n = t[0] / e.height
                    }
                    switch (t[1]) {
                        case "left":
                            r = 0;
                            break;
                        case "center":
                            r = .5;
                            break;
                        case "right":
                            r = 1;
                            break;
                        default:
                            r = t[1] / e.width
                    }
                    return {
                        x: r,
                        y: n
                    }
                },
                createWrapper: function(e) {
                    if (e.parent().is(".ui-effects-wrapper")) return e.parent();
                    var n = {
                            width: e.outerWidth(!0),
                            height: e.outerHeight(!0),
                            "float": e.css("float")
                        },
                        r = t("<div></div>").addClass("ui-effects-wrapper").css({
                            fontSize: "100%",
                            background: "transparent",
                            border: "none",
                            margin: 0,
                            padding: 0
                        }),
                        i = {
                            width: e.width(),
                            height: e.height()
                        },
                        s = document.activeElement;
                    try {
                        s.id
                    } catch (o) {
                        s = document.body
                    }
                    return e.wrap(r), (e[0] === s || t.contains(e[0], s)) && t(s).focus(), r = e.parent(), "static" === e.css("position") ? (r.css({
                        position: "relative"
                    }), e.css({
                        position: "relative"
                    })) : (t.extend(n, {
                        position: e.css("position"),
                        zIndex: e.css("z-index")
                    }), t.each(["top", "left", "bottom", "right"], function(t, r) {
                        n[r] = e.css(r), isNaN(parseInt(n[r], 10)) && (n[r] = "auto")
                    }), e.css({
                        position: "relative",
                        top: 0,
                        left: 0,
                        right: "auto",
                        bottom: "auto"
                    })), e.css(i), r.css(n).show()
                },
                removeWrapper: function(e) {
                    var n = document.activeElement;
                    return e.parent().is(".ui-effects-wrapper") && (e.parent().replaceWith(e), (e[0] === n || t.contains(e[0], n)) && t(n).focus()), e
                },
                setTransition: function(e, n, r, i) {
                    return i = i || {}, t.each(n, function(t, n) {
                        var s = e.cssUnit(n);
                        s[0] > 0 && (i[n] = s[0] * r + s[1])
                    }), i
                }
            }), t.fn.extend({
                effect: function() {
                    function e(e) {
                        function r() {
                            t.isFunction(s) && s.call(i[0]), t.isFunction(e) && e()
                        }
                        var i = t(this),
                            s = n.complete,
                            a = n.mode;
                        (i.is(":hidden") ? "hide" === a : "show" === a) ? (i[a](), r()) : o.call(i[0], n, r)
                    }
                    var n = r.apply(this, arguments),
                        i = n.mode,
                        s = n.queue,
                        o = t.effects.effect[n.effect];
                    return t.fx.off || !o ? i ? this[i](n.duration, n.complete) : this.each(function() {
                        n.complete && n.complete.call(this)
                    }) : s === !1 ? this.each(e) : this.queue(s || "fx", e)
                },
                show: function(t) {
                    return function(e) {
                        if (i(e)) return t.apply(this, arguments);
                        var n = r.apply(this, arguments);
                        return n.mode = "show", this.effect.call(this, n)
                    }
                }(t.fn.show),
                hide: function(t) {
                    return function(e) {
                        if (i(e)) return t.apply(this, arguments);
                        var n = r.apply(this, arguments);
                        return n.mode = "hide", this.effect.call(this, n)
                    }
                }(t.fn.hide),
                toggle: function(t) {
                    return function(e) {
                        if (i(e) || "boolean" == typeof e) return t.apply(this, arguments);
                        var n = r.apply(this, arguments);
                        return n.mode = "toggle", this.effect.call(this, n)
                    }
                }(t.fn.toggle),
                cssUnit: function(e) {
                    var n = this.css(e),
                        r = [];
                    return t.each(["em", "px", "%", "pt"], function(t, e) {
                        n.indexOf(e) > 0 && (r = [parseFloat(n), e])
                    }), r
                }
            })
        }(),
        function() {
            var e = {};
            t.each(["Quad", "Cubic", "Quart", "Quint", "Expo"], function(t, n) {
                e[n] = function(e) {
                    return Math.pow(e, t + 2)
                }
            }), t.extend(e, {
                Sine: function(t) {
                    return 1 - Math.cos(t * Math.PI / 2)
                },
                Circ: function(t) {
                    return 1 - Math.sqrt(1 - t * t)
                },
                Elastic: function(t) {
                    return 0 === t || 1 === t ? t : -Math.pow(2, 8 * (t - 1)) * Math.sin((80 * (t - 1) - 7.5) * Math.PI / 15)
                },
                Back: function(t) {
                    return t * t * (3 * t - 2)
                },
                Bounce: function(t) {
                    for (var e, n = 4;
                        ((e = Math.pow(2, --n)) - 1) / 11 > t;);
                    return 1 / Math.pow(4, 3 - n) - 7.5625 * Math.pow((3 * e - 2) / 22 - t, 2)
                }
            }), t.each(e, function(e, n) {
                t.easing["easeIn" + e] = n, t.easing["easeOut" + e] = function(t) {
                    return 1 - n(1 - t)
                }, t.easing["easeInOut" + e] = function(t) {
                    return .5 > t ? n(2 * t) / 2 : 1 - n(-2 * t + 2) / 2
                }
            })
        }()
}(jQuery);
