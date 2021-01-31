/system script remove func_formatDate;
/system script add name="func_formatDate" policy=read comment="Function: func_formatDate" source=":local getCurrentDateTime [:parse [/system script get func_getCurrentDateTime source]];\n:local dateTime [\$getCurrentDateTime];\n:return ((\$dateTime->\"year\") . \"-\" . (\$dateTime->\"mm\") . \"-\" . (\$dateTime->\"day\"));"
