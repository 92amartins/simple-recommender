jaccard <- function(a, b){
  length(intersect(a, b)) / length(union(a, b))
}

