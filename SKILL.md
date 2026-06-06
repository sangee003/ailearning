---
name: lineage
Perfect — let’s extend the skill so it not only discovers direct column flows but also **captures transformations** like `SUM`, `AVG`, `CASE`, `CONCAT`, etc., and includes them in the lineage diagram.  

---

## 🛠️ Skill: Dynamic Critical Field Lineage with Transformations → Draw.io XML  

**Description:**  
This skill reads an Excel sheet of critical fields, parses SQL files to discover column flows, detects transformations applied to those fields, filters lineage only for the critical fields, and generates a **Draw.io XML diagram**. Parent table columns not listed in the Excel are excluded.  

---

### 📋 Workflow Steps  

1. **Read Critical Fields Excel**  
   ```python
   import pandas as pd
   critical_fields = pd.read_excel("critical_fields.xlsx")["ColumnName"].tolist()
   ```

2. **Parse SQL Files**  
   - Use `sqlparse` or regex to extract column references.  
   - Detect transformations applied to critical fields:  
     - `SUM(TotalAmount)` → aggregation lineage  
     - `CASE WHEN ... THEN ... END` → conditional lineage  
     - `CONCAT(FirstName, LastName)` → derived lineage  

3. **Filter Lineage**  
   - Keep only the columns listed in the Excel.  
   - Ignore all other parent table columns.  

4. **Generate Draw.io XML**  
   - Create nodes for tables/views.  
   - Add edges labeled with critical fields and transformations.  
   - Export as `.drawio` XML file.  

---

### 📄 Example Python Implementation  

```python
import pandas as pd
import sqlparse
import re

def parse_sql_for_lineage(sql_files, critical_fields):
    lineage = []
    for file in sql_files:
        with open(file, "r") as f:
            sql = f.read()
        statements = sqlparse.parse(sql)
        for stmt in statements:
            text = str(stmt)
            for field in critical_fields:
                if re.search(rf"\b{field}\b", text, re.IGNORECASE):
                    # Detect transformations
                    if re.search(rf"SUM\(\s*{field}\s*\)", text, re.IGNORECASE):
                        lineage.append((field, file, "SUM"))
                    elif re.search(rf"AVG\(\s*{field}\s*\)", text, re.IGNORECASE):
                        lineage.append((field, file, "AVG"))
                    elif re.search(rf"CASE.*{field}", text, re.IGNORECASE):
                        lineage.append((field, file, "CASE"))
                    elif re.search(rf"CONCAT.*{field}", text, re.IGNORECASE):
                        lineage.append((field, file, "CONCAT"))
                    else:
                        lineage.append((field, file, "Direct"))
    return lineage

def generate_drawio_xml(lineage, output_file="critical_lineage.drawio"):
    xml_header = '<mxfile host="app.diagrams.net">\n  <diagram name="Critical Column Lineage" id="criticalLineage">\n    <mxGraphModel>\n      <root>\n        <mxCell id="0" />\n        <mxCell id="1" parent="0" />\n'
    xml_footer = '      </root>\n    </mxGraphModel>\n  </diagram>\n</mxfile>'
    
    # Create nodes dynamically
    tables = set([table for _, table, _ in lineage])
    nodes = []
    x, y = 50, 50
    for table in tables:
        nodes.append(f'<mxCell id="{table}" value="{table}" style="shape=rectangle;fillColor=#dae8fc;strokeColor=#6c8ebf;" vertex="1" parent="1"><mxGeometry x="{x}" y="{y}" width="160" height="60" as="geometry"/></mxCell>')
        x += 200
    
    # Create edges with transformation labels
    edges = []
    edge_id = 100
    for field, table, transform in lineage:
        label = f"{field} ({transform})" if transform != "Direct" else field
        edges.append(f'<mxCell id="{edge_id}" value="{label}" edge="1" parent="1" source="{table}" target="Report" style="endArrow=block;strokeColor=#d79b00;"><mxGeometry relative="1" as="geometry"/></mxCell>')
        edge_id += 1
    
    xml_content = xml_header + "\n".join(nodes + edges) + "\n" + xml_footer
    
    with open(output_file, "w") as f:
        f.write(xml_content)

# Example usage:
critical_fields = pd.read_excel("critical_fields.xlsx")["ColumnName"].tolist()
sql_files = ["Customer.sql", "Sales.sql", "v_customer_report.sql"]
lineage = parse_sql_for_lineage(sql_files, critical_fields)
generate_drawio_xml(lineage)
```

---

### ✅ Outcome  
- Reads Excel → filters only critical fields.  
- Parses SQL → discovers column flows **and transformations**.  
- Outputs **Draw.io XML** → ready to open in diagrams.net.  
- Diagram shows **only the specified columns**, with transformation labels like `(SUM)`, `(CASE)`, `(CONCAT)`.  

---

s