module.exports = {
  render: _ => {

    const n = _.n * 2

    return `select * from ${_.table} limit ${n}`
  }
}