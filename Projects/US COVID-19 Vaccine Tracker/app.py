import dash
from dash import dcc
from dash import html
import plotly.express as px
import pandas as pd
import plotly.graph_objs as go
from dash.dependencies import Input, Output
import dash_table

# assume you have a "long-form" data frame
# see https://plotly.com/python/px-arguments/ for more options

#Data setting for graph 1
data_J = pd.read_csv("COVID-19_Vaccinations_in_the_United_States_Jurisdiction.csv")
df1 = data_J.copy()
df1["Date"] = df1["Date"].astype("datetime64[ns]")
df1["Days"] = df1["Date"] - df1["Date"].min()
df1['Days'] = pd.to_numeric(df1['Days'].dt.days, downcast='integer')

#Data setting for table 2
data_C = pd.read_csv("COVID-19_Vaccinations_in_the_United_States_County.csv")
data_C = data_C[["Date", "Recip_County", "Recip_State","Series_Complete_Pop_Pct", "Administered_Dose1_Pop_Pct"]]
df2 = data_C.copy()
df2["Date"] = df2["Date"].astype("datetime64[ns]")
df2["Days"] = df2["Date"] - df2["Date"].min()
df2['Days'] = pd.to_numeric(df2['Days'].dt.days, downcast='integer')
df2_1 = df2[["Recip_County", "Series_Complete_Pop_Pct", "Administered_Dose1_Pop_Pct"]]


#-----

app = dash.Dash(__name__)

#------------------------------------------------------

app.layout = html.Div([
    #Title
    html.H1("US COVID-19  DATA TRACKER", style = {'textAlign' : 'center'}),
    
    #Date
    html.Div(children = [
    	html.Label("Date : "),
        dcc.Input(id = "what_date", type = "text"),
    

    #vaccine or dose1
    html.Br(),
    dcc.RadioItems(id = "choose_plot_kind",
        options = [
            {'label' : 'Fully Vaccinated', 'value' : 'vaccine'},
            {'label' : 'At least 1 dose', 'value' : 'dose'}
        ],
        value = 'vaccine'
        ),

    #plot
    html.Br(),
    dcc.Graph(id = 'update_figure'),


    #slider
    html.Br(),
    dcc.Slider(id = "slider_date",
        max = df1["Days"].max(),
        min = df1["Days"].min(),
        value = df1["Days"].max())


	], style = {'textAlign' : 'center'}),
    #Graph 1 ----------------------------------------


    #Table 2~ (Left)-----------------------------------------
	html.Div(children = [
		html.Label("State"),
		dcc.Dropdown(id = "states-dpdn",
			options = [
				{'label' : i, 'value' : i} for i in sorted(df2["Recip_State"].unique())
			], value = 'AK', clearable = False
			),


		html.Label("Sort by : "),
	    dcc.RadioItems(id = "sort_by",
	        options = [
	            {'label' : 'None', 'value' : 'None'},
	            {'label' : 'Fully Vacc', 'value' : 'Fully Vacc'},
	            {'label' : 'At least 1', 'value' : 'At least 1'}
	        ],
	        value = 'None'
	        ),


	    html.Label("Order : "),
	    dcc.RadioItems(id = "order_by",
	        options = [
	            {'label' : 'Increasing', 'value' : 'Increasing'},
	            {'label' : 'Decreasing', 'value' : 'Decreasing'}
	        ],
	        value = 'Decreasing'
	        ),



	    html.Label("Date : "),
        dcc.Input(id = "what_date2", type = "text"),


#		dash_table.DateTable(
#			id = 'datatable',
#			columns = [{"name" : i, "id" : i} for i in df2_1.colnumns] 
#			),




		dcc.Slider(id = "slider_date2",
			max = df2["Days"].max(),
			min = df2["Days"].min(),
			value = df2["Days"].max()
			)



		], style = {'textAlign' : 'left' , "width" : "50%", 'display': 'inline-block'}),
	

	#Table 2~(Right)------------------------------------------
	html.Div(children = [
		html.Label("County"),
		dcc.Dropdown(id = "counties-dpdn",
			options = [], clearable = False
			), 



		], style = {'textAlign' : 'left', "width" : "50%", 'display': 'inline-block'}),


])
#-------------------------------------------------------
@app.callback(
    Output('update_figure', 'figure'),
    [Input('choose_plot_kind', 'value')],
    [Input('slider_date', 'value')]
    )
def update_graph(plot_kind , year_chosen):
    filtered_df = df1[df1["Days"] == year_chosen]
    kind_of_plot = plot_kind

    fig = go.Figure(data = go.Choropleth(
        locations = filtered_df["Location"],
        z = filtered_df["Series_Complete_Pop_Pct"].astype(float),
        locationmode = "USA-states",
        colorscale = "Blues",
        colorbar_title = "Percentage",
        autocolorscale= False,
        zmin = 0,
        zmax = 100
        ))

    fig.update_layout(
        geo_scope = 'usa'
        )

    fig2 = go.Figure(data = go.Choropleth(
        locations = filtered_df["Location"],
        z = filtered_df["Administered_Dose1_Pop_Pct"].astype(float),
        locationmode = "USA-states",
        colorscale = "Blues",
        colorbar_title = "Percentage",
        autocolorscale= False,
        zmin = 0,
        zmax = 100
        ))

    fig2.update_layout(
        geo_scope = 'usa'
        )

    if kind_of_plot == 'vaccine':
        return (fig)
    else:
        return(fig2)

@app.callback(
    Output("what_date", "value"),
    [Input("slider_date", "value")]
    )
def whatdate(year_chosen):
    filtered_df = df1[df1["Days"] == year_chosen]
    actual_date = filtered_df["Date"].astype("str").values[0]
    return(actual_date)

#Graph 1 until here.

@app.callback(
	Output('counties-dpdn', 'options'),
	[Input('states-dpdn', 'value')]
	)
def set_cities_options(chosen_state):
	dff = df2[df2.Recip_State == chosen_state]
	return [{'label' : c, 'value' : c} for c in sorted(dff.Recip_County.unique())]



#@app.callback(
#	Output('datatable', 'data'),
#	[Input('states-dpdn', 'value')],
#	[Input('counties-dpdn', 'value')],
#	[Input('slider_date2', 'value')]
#)

#def makedataframe(chosen_state, chosen_county, chosen_date):
#	df_filtered = df2[(df2.Recip_State == chosen_state) | (df2.Recip_County == chosen_county) | (df2.Days == chosen_date)]
#	df_filtered2 = df_filtered[["Recip_County", "Series_Complete_Pop_Pct", "Administered_Dose1_Pop_Pct"]]
#	return (df_filtered2)


@app.callback(
    Output("what_date2", "value"),
    [Input("slider_date2", "value")]
    )
def whatdate(year_chosen):
    filtered_df = df2[df2["Days"] == year_chosen]
    actual_date = filtered_df["Date"].astype("str").values[0]
    return(actual_date)




if __name__ == '__main__':
    app.run_server(debug=True)

