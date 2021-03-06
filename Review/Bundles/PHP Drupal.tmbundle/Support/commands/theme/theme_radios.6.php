/**
 * Format a set of radio buttons.
 *
 * @param \$element
 *   An associative array containing the properties of the element.
 *   Properties used: title, value, options, description, required and attributes.
 * @return
 *   A themed HTML string representing the radio button set.
 *
 * @ingroup themeable
 */
function ${1:phptemplate}_radios(\$element) {
  \$class = 'form-radios';
  if (isset(\$element['#attributes']['class'])) {
    \$class .= ' '. \$element['#attributes']['class'];
  }
  \$element['#children'] = '<div class="'. \$class .'">'. (!empty(\$element['#children']) ? \$element['#children'] : '') .'</div>';
  if (\$element['#title'] || \$element['#description']) {
    unset(\$element['#id']);
    return theme('form_element', \$element, \$element['#children']);
  }
  else {
    return \$element['#children'];
  }
}

$2