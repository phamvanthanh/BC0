//
// filters.js
//
function filterBy(list, value) {
  return list.filter(function(item) {
    return item.indexOf(value) > -1;
  });
}

function findBy(list, value) {
  return list.filter(function(item) {
    return item == value
  });
}

function reverse(value) {
  return value.split('').reverse().join('');
}


function capitalize (value) {
     if (!value) return ''
     value = value.toString()
     return value.charAt(0).toUpperCase() + value.slice(1)
}


export {filterBy, reverse, findBy, capitalize}