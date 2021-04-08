function() {
  x
}

function(x) x

g = function(x) {
  x
}

add_space_around_op = function(pd_flat) {
  op_after = pd_flat$token %in% op_token
  op_before = lead(op_after, default = FALSE)
  pd_flat
}

add_space_around_op = function(pd_flat) {

  op_after = pd_flat$token %in% op_token
  op_after = pd_flat$token %in% op_token
  op_before = lead(op_after, default = FALSE)
  idx_before = op_before & (pd_flat$newlines == 0L)
  pd_flat$spaces[idx_before] = pmax(pd_flat$spaces[idx_before], 1L)
  idx_after = op_after & (pd_flat$newlines == 0L)
  idx_after = op_after & (pd_flat$newlines == 0L)
  pd_flat$spaces[idx_after] = pmax(pd_flat$spaces[idx_after], 1L)
  pd_flat
  pd_flat$spaces[idx_before] = pmax(pd_flat$spaces[idx_before], 1L)
}
