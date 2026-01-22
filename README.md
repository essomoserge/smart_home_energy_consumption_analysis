<h2>Smart Home Energy Consumption Analysis</h2>

<p>
Data analytics project showcasing smart home energy consumption analysis using Python, MySQL, and Power BI to uncover usage patterns, peak demand, and abnormal consumption, supporting energy efficiency insights and data-driven decision-making.
</p>

<h3>📊 Overview</h3>
<p>
This data analytics project analyzes residential energy usage patterns using smart home monitoring data. The goal is to identify inefficiencies, detect abnormal consumption, and provide actionable insights for energy optimization. The analysis follows a multi-layered approach using Python for exploratory analysis and modeling, SQL for relational validation, and Power BI for interactive reporting.
</p>

<h3>📁 Dataset</h3>
<p>
Source: Kaggle – Smart Home Energy Consumption Dataset<br>
Period: January 2023 – January 2024<br>
Records: ~100,000 energy consumption logs
</p>
<p>
Key Variables: Home ID, Appliance Type, Energy Consumption (kWh), Timestamp, Outdoor Temperature, Season, Household Size<br>
Engineered Features: Time segments, energy consumption per person, high-energy flags, temperature extremes
</p>

<h3>🛠️ Tools &amp; Technologies</h3>
<ul>
<li>Excel: Initial data validation</li>
<li>Python (pandas, numpy, matplotlib, seaborn, scikit-learn): Data cleaning, EDA, feature engineering, visualization, predictive modeling</li>
<li>MySQL: Relational queries, aggregation, and validation</li>
<li>Power BI &amp; DAX: Interactive dashboard development</li>
<li>Gamma / PowerPoint: Presentation and reporting</li>
</ul>

<h3>📈 Project Steps</h3>

<h4>1. Data Loading &amp; Initial Inspection</h4>
<ul>
<li>Load dataset into Python using pandas</li>
<li>Check for missing values, duplicates, and data types</li>
<li>Validate structure and consistency in Excel</li>
</ul>

<h4>2. Data Cleaning &amp; Feature Engineering (Python)</h4>
<ul>
<li>Handle missing timestamps and invalid readings</li>
<li>Create derived features: time segments, energy per person, high-energy flag, extreme temperature indicator</li>
<li>Normalize and prepare data for analysis</li>
</ul>

<h4>3. Exploratory Data Analysis (Python + SQL)</h4>
<ul>
<li>Analyze energy distribution and baseline metrics</li>
<li>Examine household size representation</li>
<li>Compare energy per person across household sizes</li>
<li>Identify top-consuming appliances</li>
<li>Study seasonal and time-of-day patterns</li>
<li>Detect anomalies and inefficiencies</li>
</ul>

<h4>4. Relational Validation (SQL)</h4>
<ul>
<li>Create database schema and load cleaned data</li>
<li>Run aggregation queries to validate Python findings</li>
<li>Perform cross-dimensional comparisons</li>
</ul>

<h4>5. Dashboard Development (Power BI)</h4>
<ul>
<li>Import processed data into Power BI</li>
<li>Create DAX measures</li>
<li>Build dashboards showing consumption trends, appliance breakdowns, and anomalies</li>
</ul>

<h4>6. Reporting &amp; Presentation</h4>
<ul>
<li>Summarize insights in a professional report</li>
<li>Create presentation slides</li>
<li>Highlight business recommendations</li>
</ul>

<h3>📊 Dashboard Preview</h3>
<p>
The Power BI dashboard enables filtering by household size, season, and appliance type, shows peak demand periods, identifies top-consuming households, analyzes temperature impact, and highlights abnormal consumption patterns.
</p>

<h3>📋 Key Results &amp; Insights</h3>
<ul>
<li>HVAC systems are the primary drivers of energy consumption</li>
<li>Evening hours represent peak demand</li>
<li>Household size has minimal impact on appliance-level usage</li>
<li>Larger households show marginal per-person efficiency gains</li>
<li>Extreme temperatures increase abnormal energy events</li>
<li>A small subset of households drives disproportionate demand</li>
</ul>

<h3>🚀 How to Run This Project</h3>

<h4>Prerequisites</h4>
<p>
Python 3.8+, MySQL, Power BI Desktop, Jupyter Notebook or preferred IDE
</p>

<h4>Setup Instructions</h4>
<p>
Clone the repository:
</p>
<pre>
git clone https://github.com/yourusername/smart-home-energy-analysis.git
cd smart-home-energy-analysis
</pre>

<p>
Install dependencies:
</p>
<pre>
pip install -r requirements.txt
</pre>

<p>
Download the dataset from Kaggle and place it in the <code>data/</code> folder.
</p>

<p>
Run the analysis:
</p>
<pre>
jupyter notebook analysis/energy_analysis.ipynb
</pre>

<p>or</p>

<pre>
python analysis/energy_pipeline.py
</pre>

<p>
Set up the database by creating a MySQL database, updating <code>config/db_config.yaml</code>, and running SQL scripts in <code>sql/</code>.<br>
Open the Power BI dashboard at <code>dashboard/smart_energy_dashboard.pbix</code> and refresh data if needed.
</p>

<h3>📁 Repository Structure</h3>
<pre>
smart-home-energy-analysis/
├── data/
├── analysis/
├── sql/
├── dashboard/
├── presentation/
├── reports/
├── config/
├── media/
├── requirements.txt
└── README.md
</pre>

<h3>📄 License</h3>
<p>
This project is for educational and portfolio purposes. Dataset sourced from Kaggle.
</p>

<h3>👤 Author</h3>
<p>
<strong>Serge Essomo</strong><br>
<a href="#">https://github.com/essomoserge</a> | <a href="#">https://www.linkedin.com/in/serge-essomo-5946b8142</a> | <a href="#">https://www.kaggle.com/sergio2cm</a>
</p>
