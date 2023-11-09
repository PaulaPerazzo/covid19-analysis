# data analysis of covid cases

using Pkg
using CSV
using DataFrames
Pkg.add("Plots")
using Plots

plot()

covid = CSV.read("day_wise.csv", DataFrame, normalizenames=true)

## --------- visualização de dados do número de casos ---------------------- ##

x_axis = covid.Date
confirmed_cases = covid.Confirmed
countries = covid.No_of_countries
deaths = covid.Deaths
new_cases = covid.New_cases

p_plot = plot(x_axis, confirmed_cases, label="confirmed cases", xlabel="date")
plot!(p_plot, x_axis, deaths, label="deaths")
plot!(p_plot, x_axis, new_cases, label="new_cases")

## --------- visualização de dados do número de casos dividido por continente ---------------------- ##

covid_country_wise = CSV.read("country_wise_latest.csv", DataFrame, normalizenames=true)
x_axis_bar = covid_country_wise.WHO_Region
y_axis_bar = covid_country_wise.Confirmed
p_bar = bar(x_axis_bar, y_axis_bar, label="confirmed cases per region")

## --------- visualização de dados do número de casos na américa ---------------------- ##

filtered_data = filter(row -> row.WHO_Region == "Americas", covid_country_wise)
filtered_data2 = filter(row -> row.Confirmed > 100000, filtered_data)
x_axis_americas = filtered_data2.Country_Region
y_axis_americas = filtered_data2.Confirmed
p_bar_americas = bar(x_axis_americas, y_axis_americas, size=(1000, 400), label="confirmed cases per region")
deaths_america = filtered_data2.Deaths
bar!(p_bar_americas, x_axis_americas, deaths_america, label="deaths")
p_bar_americas

## --------- visualização de dashboard com todos os gráficos ---------------------- ##

plot(p_plot, p_bar, p_bar_americas, layout=(2, 2))


## --------- previsão de dados ---------------------- ##

using ScikitLearn

date = covid.Date
date_string = string.(date)
deaths = covid.Deaths

plot()

death_plot = plot(date_string, deaths, label="deaths per time")

@sk_import linear_model:LogisticRegression
@sk_import model_selection:train_test_split

x_train, x_test, y_train, y_test = train_test_split(date_string, deaths)

regression_model = LogisticRegression()
fit!(regression_model, x_train, y_train)