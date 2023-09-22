# data analysis of covid cases

using Pkg
using CSV
using DataFrames
Pkg.add("Plots")
using Plots

plot()

covid = CSV.read("day_wise.csv", DataFrame, normalizenames=true)

x_axis = covid.Date
confirmed_cases = covid.Confirmed
countries = covid.No_of_countries
deaths = covid.Deaths
new_cases = covid.New_cases

p_plot = plot(x_axis, confirmed_cases, label="confirmed cases", xlabel="date")
plot!(p_plot, x_axis, deaths, label="deaths")
plot!(p_plot, x_axis, new_cases, label="new_cases")

p_bar = bar(x_axis, confirmed_cases, label="confirmed cases")
scatter(x_axis, confirmed_cases)

plot(p_plot, p_bar, layout=(2,1))
