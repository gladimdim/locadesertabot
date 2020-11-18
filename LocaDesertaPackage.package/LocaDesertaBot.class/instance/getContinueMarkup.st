as yet unclassified
getContinueMarkup
| array markup|
array := { { Dictionary newFrom: {#text -> 'Продовжити'}} }.
markup := Dictionary new.
markup at: 'keyboard' put: array; at: 'resize_keyboard' put: true.
^ markup