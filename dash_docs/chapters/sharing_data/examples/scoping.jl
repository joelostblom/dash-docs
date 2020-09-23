using Dash
using DashHtmlComponents
using DashCoreComponents
using DataFrames

df = DataFrame(a = [1, 2, 3],
               b = [4, 1, 4],
               c = ["x", "y", "z"])

app = dash()

app.layout = html_div() do
    dcc_dropdown(id="dropdown",
                 options = [
                    (label = i, value = i) for i in df["c"]
                 ],
                 value="x"
    ),
    html_div(id="output")
end

callback!(
    app,
    Output("output", "children"),
    Input("dropdown", "value"),
) do value
    dff = filter(row -> row.c == value, df)

    print(callback_context())
    return length(dff[1, :])
end

run_server(app, "0.0.0.0", 8000, debug=true)
