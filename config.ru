root = ::File.dirname(__FILE__)
require ::File.join(root, 'listelista')

app = App.mount
run app