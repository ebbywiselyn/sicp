;;; Exercise 3.15.  Draw box-and-pointer diagrams to explain the effect 
;;; of set-to-wow! on the structures z1 and z2 . 

;;; z1 -> [x][x]
;;; x -> [a][]->[b][]
;;; (set-to-wow! z1)
;;; z1 -> [x][x]
;;; x['wow][] -> [b][]
;;; hence z1 -> [['wow][]][['wow][]]

;;; z2 -> [x][y]
;;; x -> [a][] -> [b][]
;;; y -> [a][] -> [b][]
;;; where a, b in both x and y 
;;; are the same objects.
;;; (set-to-wow! z2)
;;; z2 -> [x][y]
;;; x -> ['wow][] -> [b][]
;;; y -> [a][] -> [b][]
;;; hence z2 -> [['wow][] -> [b][]] [[a][] -> [b][]]






