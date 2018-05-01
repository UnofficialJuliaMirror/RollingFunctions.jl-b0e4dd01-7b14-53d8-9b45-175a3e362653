mad_not_normalized(x) = mad(x, normalize=false)
mad_normalized(x) = mad(x, normalize=true)

var1(x) = length(x) > 1 ? var(x) : 0.0
std1(x) = length(x) > 1 ? std(x) : 0.0
sem1(x) = length(x) > 1 ? sem(x) : 0.0
variation1(x) = length(x) > 1 ? variation(x) : 0.0
skewness1(x) = length(x) > 1 ? skewness(x) : 1.0
kurtosis1(x) = length(x) > 1 ? kurtosis(x) : -1.0


for (R,F) in ((:rollmin, :minimum), (:rollmax, :maximum),
              (:rollmean, :mean), (:rollmedian, :median), 
              (:rollvar, :var), (:rollstd, :std),
              (:rollskewness, :skewness), (:rollkurtosis, :kurtosis),
              (:rollsem, :sem), 
              (:rollmad, :mad_not_normalized),
              (:rollmad_normalized, :mad_normalized),
              (:rollvariation, :variation))
    @eval begin
        $R(data::AbstractVector{T}, windowspan::Int) where {T} =
            rolling($F, data, windowspan)
        $R(data::AbstractVector{T}, windowspan::Int, weights::AbstractVector{S}) where {T,S} =
            rolling($F, data, windowspan, weights)
        $R(data::AbstractVector{T}, windowspan::Int, weights::AbstractWeights) where {T} =
            rolling($F, data, windowspan, weights.values)
    end
end


for (R,F) in ((:runmin, :minimum), (:runmax, :maximum),
              (:runmean, :mean), (:runmedian, :median), 
              (:runvar, :var1), (:runstd, :std1),
              (:runskewness, :skewness1), (:runkurtosis, :kurtosis1),
              (:runsem, :sem1), 
              (:runmad, :mad_not_normalized),
              (:runmad_normalized, :mad_normalized),
              (:runvariation, :variation1))
    @eval begin
        $R(data::AbstractVector{T}, windowspan::Int) where {T} =
            running($F, data, windowspan)
    end
end
