#NIVELL03
#Crea una taula amb la qual puguem unir les dades del nou arxiu products.csv amb la base de dades creada, tenint en compte que des de transaction tens product_ids. Genera la següent consulta:
#Exercici 1
#Necessitem conèixer el nombre de vegades que s'ha venut cada producte.

#L'unio de les taules ja la he fet previament en el primer EX.

CREATE TABLE sales_products
SELECT count(id) as NumProducte,product_name AS NomProducte,id As NumId
FROM products
JOIN (
SELECT product1, product2, product3, product4
FROM transactions2
WHERE declined= 0 ) Subq1
ON Subq1.product1 = products.id or Subq1.product2= products.id or Subq1.product3= products.id or Subq1.product4= products.id
GROUP BY product_name,id;


# comprobacion: 
SELECT count(id)
FROM transactions2
where declined=0 and (product1=13 or product2=13 or product3=13 or product4=13);


