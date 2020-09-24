### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 6fbd5f0a-fdbb-11ea-3704-bfe27c4274ff
begin
	using Pkg
	Pkg.activate("..")
end

# ╔═╡ e0cd0a20-fdba-11ea-1528-c76e1b9686aa
using CSV

# ╔═╡ adec3a0c-fdc1-11ea-1e8f-733064d7d376
using DataFrames

# ╔═╡ e0b20f42-fdc7-11ea-02f5-09b00b3a2686
using PlutoUI

# ╔═╡ 332f20c4-fde9-11ea-324d-ab3aae89c0d8
using Plots

# ╔═╡ ab11677a-fdea-11ea-3dbc-e3314f943d60
using Dates

# ╔═╡ b40373ae-fda5-11ea-3bb8-6588a2f4053e
md"""# Computational Thinking in Julia
## Lecture 1 : Data Analysis

1. Understand data
2. Build models
3. Fit models
"""

# ╔═╡ 92a289f4-fdbc-11ea-1581-bf0b126bae6e
md"
When using Pluto.jl, we first have to activate the Project. This is achieved by runnig the following cell. Notice how we use begin and end. Due to the reactive nature of Pluto we must either use this **begin** - **end** construct or split code into individual cells.
"

# ╔═╡ b1823f0e-fdb5-11ea-0331-296e1cdc568e
url = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"

# ╔═╡ ecb01902-fdb7-11ea-0434-fd05fea24eee
typeof(url)

# ╔═╡ f174eaf8-fdb7-11ea-1ff3-ff4671f0bc34
md"
We can even have some inline _tex_ :
$ 
	\int f(x) 
$

Or proper latex begin and end quation **tags** :
\begin{equation}
	\sum_{i=0}^{5} = 6
\end{equation}
"

# ╔═╡ 1bb83814-fdb9-11ea-1b32-81f498bab1fe
x = 5

# ╔═╡ d4c23506-fdbb-11ea-010a-a1741ace1cd7
x * x

# ╔═╡ 2173d7a4-fdb9-11ea-39c6-713d07ccc44b
typeof(3)

# ╔═╡ 42e4eac2-fdb9-11ea-23a3-3b9feb59d914
md"
Weirdly enough, string multiplication is concatenation ?
"

# ╔═╡ 281ca7b6-fdb9-11ea-0d8d-5fe061fc7a0f
url * url

# ╔═╡ 63f4d07e-fdb9-11ea-0cfa-09b46b29a035
"foo  a lot    of space    " * url

# ╔═╡ 81a51d22-fdb9-11ea-25cf-e9a2984a135d
md"
Just calling an operation will unveil all the methods defined for said functions. These can later be inspected via many _magic methods_ (I'm calling them magic but this is unofficial, please do not quote me on this either haha.

1. ``` methods(func) ``` : A list of available methods for func
2. ``` @which func(args) ``` :  Show which method is being used.
"

# ╔═╡ 6c026524-fdb9-11ea-25eb-f196aeedb57c
*

# ╔═╡ 705426b2-fdb9-11ea-28c8-57518866fe56
# methods(*)
@which 3 * 3

# ╔═╡ bf43b7d0-fdba-11ea-1daf-19f6dd77b690
md" Grab the data "

# ╔═╡ c945f754-fdba-11ea-1e05-1931ef837685
download(url, "covid_data.csv")

# ╔═╡ d3f45376-fdba-11ea-1671-4b8067bab5ec
readdir()

# ╔═╡ 63e374fc-fdbc-11ea-2717-9d809e47ff5a
data = CSV.read("covid_data.csv");

# ╔═╡ 9f1bece8-fdc1-11ea-2782-5718741b197c
typeof(data)

# ╔═╡ 71965ed2-fdc3-11ea-2e4d-b9d9e44b1fa9
md"
## Homework

1. Learn to use DataFrames
 * Read the Docs
 * Maybe Julia Academy ?
"

# ╔═╡ cbb65732-fdc3-11ea-1f49-116fe8937e2e
rename!(data, 1 => "province", 2 => "country")

# ╔═╡ e787858c-fdc3-11ea-2439-b9505535cc40
md"
Bang is a convention that says that the function modifies its argument, 
a.k.a. *in_place*
"

# ╔═╡ 560a2cec-fdc4-11ea-2314-a90996f082c4
# This will only work on an actual Jupyter Notebook.
#?rename # just like in R :)

# ╔═╡ 94f22f5e-fdc4-11ea-118e-d7ad506edb09
md"""

"""

# ╔═╡ 358ce53e-fdc6-11ea-39de-efd0f76c26d1
#using Interact

# ╔═╡ d93db020-fdc4-11ea-24bc-796f8d571b3d
for i in 1:10
	i
end

# ╔═╡ 4dea10d0-fdc5-11ea-10f3-191e94fd7731
@bind foo Slider(1:100)

# ╔═╡ f1673240-fdc7-11ea-29c6-c1dcc96b1f04
foo

# ╔═╡ 8d85ac9c-fdc8-11ea-0559-d74c8b015182
@bind bar Clock()

# ╔═╡ 9abbe30c-fdc8-11ea-0598-654e9da58df3
bar

# ╔═╡ add5f5e4-fdc8-11ea-3e8a-59070499a54e
# One can use the standard pythonic : to select all, tho
countries = data[1:end, 2]

# ╔═╡ 1a36b56e-fdc9-11ea-32f3-03bb512b590e
@which collect(data[:, 2])

# ╔═╡ 4803ed86-fdc9-11ea-1c65-2de866ec01f1
countries2 = collect(data[:, 2])

# ╔═╡ 61ed0ee4-fdc9-11ea-2d41-d52fe963c8ec
begin
	t1 = typeof(countries)
	t2 = typeof(countries2)
end

# ╔═╡ 78109e2a-fdc9-11ea-1f6b-09ae833c239b
t1 == t2 

# ╔═╡ 87c2f8fc-fdc9-11ea-3e31-8957657eaef9
unique_countries = unique(countries)

# ╔═╡ 84e9a058-fde0-11ea-3987-4ffcad4de89e
@bind i Slider(1:length(countries))

# ╔═╡ 6fe9f4f4-fde1-11ea-1359-65f5fe209b06
countries[i]

# ╔═╡ 0ad42b7e-fde2-11ea-2cb2-f51f9f032d92
@bind the_country Select(countries)

# ╔═╡ 3354cc34-fde2-11ea-1ff2-cfa7fe66c3db
the_country

# ╔═╡ 50c1c9e8-fde2-11ea-2fe0-591cc756cb2e
md"""
Array comprehension
"""

# ╔═╡ b918f368-fde2-11ea-0b4a-578a5deafb30
M_countries = [startswith(country, "M") for country in countries]

# ╔═╡ e5a140f0-fde2-11ea-1ae8-1d6315deefc8
data[M_countries, :]

# ╔═╡ 2421bc80-fde8-11ea-1cc5-cff533010acd


# ╔═╡ 218a1b0c-fde8-11ea-2b20-e32c0a1b4d3a
md"""
A vector is not equal to a string, so we expect false.
"""

# ╔═╡ 04e20992-fde8-11ea-33c9-bb590743a10a
countries == the_country

# ╔═╡ 5018b190-fde8-11ea-3c88-e1934b9e3888
md"""
We can, however, _broadcast_ the operation.
"""

# ╔═╡ 18237c02-fde8-11ea-3d6b-032919c29525
countries .== the_country

# ╔═╡ 787d4dda-fde8-11ea-2a5e-a5618594713d
md"""
Which one ?
"""

# ╔═╡ 82ffd5fc-fde8-11ea-386f-8746927ffade
the_index = findfirst(countries .== the_country);

# ╔═╡ 9d6ca7ce-fde8-11ea-1c7a-957c948c1ccd
our_data_row = data[the_index, :]

# ╔═╡ e01a032a-fde8-11ea-27bb-39386334d88b
# Assuming that you want Mexico as well.
mx_data = convert(Vector, our_data_row[5:end])

# ╔═╡ a4869da4-fde9-11ea-3048-d7e6dbe68668
plot(mx_data)

# ╔═╡ c754c692-fde9-11ea-1378-c1a68609a0fa
col_names = names(data)

# ╔═╡ e06dbd0c-fde9-11ea-2961-353a0b4bd0b9
typeof(col_names)

# ╔═╡ 07c8d5b2-fdea-11ea-1a48-5950fd734797
typeof(col_names[5])

# ╔═╡ 193a902e-fdea-11ea-305b-5dadc7f74b7d
md"""
Here the Julia course said that we had **Symbols** and not **Strings** but they were using Julia 1.4 and I'm on 1.5. I'll perform the reverse broadcast $ Strings \longrightarrow Symbols $ and see how that works out.
"""

# ╔═╡ 489c0bae-fdea-11ea-1c13-9ff46ea05434
# Dot means elementwise 
col_symbols = Symbol.(names(data))

# ╔═╡ 79642c08-fdea-11ea-2184-e12af232f887
date_strings = col_names[5:end]

# ╔═╡ a24b354e-fdea-11ea-3c4a-874660615037
md"""
We want to parse them into dates! 
"""

# ╔═╡ caa19b9e-fdea-11ea-2206-9137778147b6
format = Dates.DateFormat("m/d/Y")

# ╔═╡ dc07ce28-fdea-11ea-06af-a57250820d19
parse(Date, date_strings[1], format) + Year(2000)

# ╔═╡ 2fb1c592-fdeb-11ea-3c75-316722afd36a
md"""
Julia actually seems too good to be true
"""

# ╔═╡ 440e95b0-fdeb-11ea-290e-8ba59407ef4e
dates = parse.(Date, date_strings, format) .+ Year(2000);

# ╔═╡ 9a95e4f6-fdeb-11ea-1a8b-a5b2de3afe8b
begin
	plot(dates, mx_data, xticks=dates[1:21:end], xrotation=45, 
		leg=:topleft, label="Mx data", m=:o
	)
	xlabel!("date")
	ylabel!("Confirmed cases")
	title!("Julia plotting is actually nice!")
	# annotate!(dates[end], mx_data[end], 
end

# ╔═╡ 5369e4ba-fdeb-11ea-0674-53c971fe6707
md"""
And it is! Eveything is consistent
"""

# ╔═╡ 8438b976-fdec-11ea-3eab-7f11c62de2f8
md"""
## Homework :
	How to select and modify
	Actually no, fuck homework
"""

# ╔═╡ 0a369192-fded-11ea-209e-b9442bdf3746
zero_idx = mx_data .== 0

# ╔═╡ 90e519c8-fda7-11ea-1c2a-b76939ee7320
first_nonull = findfirst(.!zero_idx)

# ╔═╡ 2a5c2e44-fe03-11ea-02be-7d651d3c272a
nieuw_dates = dates[first_nonull:end]

# ╔═╡ 3c7e2564-fe03-11ea-2f03-db5d3b29ceae
nieuw_mx = mx_data[first_nonull:end]

# ╔═╡ 51bb41c8-fe03-11ea-0771-c1ba50c20954
begin
	plot(nieuw_dates, nieuw_mx, 
		xticks=dates[1:21:end], xrotation=45, 
		leg=:topleft, label="Mx data", m=:o,
		yscale=:log10
	)
	xlabel!("date")
	ylabel!("Log confirmed cases")
	title!("Julia plotting is actually nice!")
	# annotate!(dates[end], mx_data[end], 
end

# ╔═╡ 8893648e-fe03-11ea-1359-f5c5dca0c2f2
function notnulls(some_arr)
	_zero_idx = some_arr .== 0
	return some_arr[findfirst(.!_zero_idx):end]
end

# ╔═╡ d1255ff2-fe03-11ea-1748-33c5f989709c
notnulls(mx_data)

# ╔═╡ 04edcbbc-fe04-11ea-0563-b53ad5e98622
md"""
Homework
Reproduce [this](https://aatishb.com/covidtrends/?location=Brazil&location=Canada&location=China&location=France&location=India&location=Mexico&location=Singapore&location=South+Korea&location=Spain&location=Taiwan&location=US)
"""

# ╔═╡ Cell order:
# ╟─b40373ae-fda5-11ea-3bb8-6588a2f4053e
# ╟─92a289f4-fdbc-11ea-1581-bf0b126bae6e
# ╠═6fbd5f0a-fdbb-11ea-3704-bfe27c4274ff
# ╠═b1823f0e-fdb5-11ea-0331-296e1cdc568e
# ╠═ecb01902-fdb7-11ea-0434-fd05fea24eee
# ╟─f174eaf8-fdb7-11ea-1ff3-ff4671f0bc34
# ╠═1bb83814-fdb9-11ea-1b32-81f498bab1fe
# ╠═d4c23506-fdbb-11ea-010a-a1741ace1cd7
# ╠═2173d7a4-fdb9-11ea-39c6-713d07ccc44b
# ╟─42e4eac2-fdb9-11ea-23a3-3b9feb59d914
# ╠═281ca7b6-fdb9-11ea-0d8d-5fe061fc7a0f
# ╠═63f4d07e-fdb9-11ea-0cfa-09b46b29a035
# ╟─81a51d22-fdb9-11ea-25cf-e9a2984a135d
# ╠═6c026524-fdb9-11ea-25eb-f196aeedb57c
# ╠═705426b2-fdb9-11ea-28c8-57518866fe56
# ╟─bf43b7d0-fdba-11ea-1daf-19f6dd77b690
# ╠═c945f754-fdba-11ea-1e05-1931ef837685
# ╠═d3f45376-fdba-11ea-1671-4b8067bab5ec
# ╠═e0cd0a20-fdba-11ea-1528-c76e1b9686aa
# ╠═63e374fc-fdbc-11ea-2717-9d809e47ff5a
# ╠═9f1bece8-fdc1-11ea-2782-5718741b197c
# ╠═adec3a0c-fdc1-11ea-1e8f-733064d7d376
# ╟─71965ed2-fdc3-11ea-2e4d-b9d9e44b1fa9
# ╠═cbb65732-fdc3-11ea-1f49-116fe8937e2e
# ╟─e787858c-fdc3-11ea-2439-b9505535cc40
# ╠═560a2cec-fdc4-11ea-2314-a90996f082c4
# ╠═94f22f5e-fdc4-11ea-118e-d7ad506edb09
# ╠═358ce53e-fdc6-11ea-39de-efd0f76c26d1
# ╠═d93db020-fdc4-11ea-24bc-796f8d571b3d
# ╠═e0b20f42-fdc7-11ea-02f5-09b00b3a2686
# ╠═4dea10d0-fdc5-11ea-10f3-191e94fd7731
# ╠═f1673240-fdc7-11ea-29c6-c1dcc96b1f04
# ╠═8d85ac9c-fdc8-11ea-0559-d74c8b015182
# ╠═9abbe30c-fdc8-11ea-0598-654e9da58df3
# ╠═add5f5e4-fdc8-11ea-3e8a-59070499a54e
# ╠═1a36b56e-fdc9-11ea-32f3-03bb512b590e
# ╠═4803ed86-fdc9-11ea-1c65-2de866ec01f1
# ╠═61ed0ee4-fdc9-11ea-2d41-d52fe963c8ec
# ╠═78109e2a-fdc9-11ea-1f6b-09ae833c239b
# ╠═87c2f8fc-fdc9-11ea-3e31-8957657eaef9
# ╠═84e9a058-fde0-11ea-3987-4ffcad4de89e
# ╠═6fe9f4f4-fde1-11ea-1359-65f5fe209b06
# ╟─0ad42b7e-fde2-11ea-2cb2-f51f9f032d92
# ╠═3354cc34-fde2-11ea-1ff2-cfa7fe66c3db
# ╟─50c1c9e8-fde2-11ea-2fe0-591cc756cb2e
# ╠═b918f368-fde2-11ea-0b4a-578a5deafb30
# ╠═e5a140f0-fde2-11ea-1ae8-1d6315deefc8
# ╠═2421bc80-fde8-11ea-1cc5-cff533010acd
# ╟─218a1b0c-fde8-11ea-2b20-e32c0a1b4d3a
# ╠═04e20992-fde8-11ea-33c9-bb590743a10a
# ╟─5018b190-fde8-11ea-3c88-e1934b9e3888
# ╠═18237c02-fde8-11ea-3d6b-032919c29525
# ╟─787d4dda-fde8-11ea-2a5e-a5618594713d
# ╠═82ffd5fc-fde8-11ea-386f-8746927ffade
# ╠═9d6ca7ce-fde8-11ea-1c7a-957c948c1ccd
# ╠═e01a032a-fde8-11ea-27bb-39386334d88b
# ╠═332f20c4-fde9-11ea-324d-ab3aae89c0d8
# ╠═a4869da4-fde9-11ea-3048-d7e6dbe68668
# ╠═c754c692-fde9-11ea-1378-c1a68609a0fa
# ╠═e06dbd0c-fde9-11ea-2961-353a0b4bd0b9
# ╠═07c8d5b2-fdea-11ea-1a48-5950fd734797
# ╟─193a902e-fdea-11ea-305b-5dadc7f74b7d
# ╠═489c0bae-fdea-11ea-1c13-9ff46ea05434
# ╠═79642c08-fdea-11ea-2184-e12af232f887
# ╟─a24b354e-fdea-11ea-3c4a-874660615037
# ╠═ab11677a-fdea-11ea-3dbc-e3314f943d60
# ╠═caa19b9e-fdea-11ea-2206-9137778147b6
# ╠═dc07ce28-fdea-11ea-06af-a57250820d19
# ╟─2fb1c592-fdeb-11ea-3c75-316722afd36a
# ╠═440e95b0-fdeb-11ea-290e-8ba59407ef4e
# ╠═9a95e4f6-fdeb-11ea-1a8b-a5b2de3afe8b
# ╟─5369e4ba-fdeb-11ea-0674-53c971fe6707
# ╟─8438b976-fdec-11ea-3eab-7f11c62de2f8
# ╠═0a369192-fded-11ea-209e-b9442bdf3746
# ╠═90e519c8-fda7-11ea-1c2a-b76939ee7320
# ╠═2a5c2e44-fe03-11ea-02be-7d651d3c272a
# ╠═3c7e2564-fe03-11ea-2f03-db5d3b29ceae
# ╠═51bb41c8-fe03-11ea-0771-c1ba50c20954
# ╠═8893648e-fe03-11ea-1359-f5c5dca0c2f2
# ╠═d1255ff2-fe03-11ea-1748-33c5f989709c
# ╟─04edcbbc-fe04-11ea-0563-b53ad5e98622
