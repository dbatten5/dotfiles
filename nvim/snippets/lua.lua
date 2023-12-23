return {
  s("req", fmt('require("{}")', { i(1) })),
  s("lreq", fmt('local {} = require("{}")', { rep(1), i(1) })),
}
