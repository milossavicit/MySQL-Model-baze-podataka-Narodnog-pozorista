/**
 *
 * @author Miloš
 */
import java.sql.*;
import java.util.ArrayList;

public class Main {

public static Connection getConnection() throws Exception{
 try{
     String driver = "com.mysql.jdbc.Driver";
     String url = "jdbc:mysql://localhost:3306/Narodno_pozorište?useUnicode=true&amp;characterEncoding=utf8";
     String username = "root";
     String password = "";
     Class.forName(driver); Connection conn = DriverManager.getConnection(url,username,password);
     System.out.println("Uspešno konektovano.");
     return conn;
} catch(Exception e){System.out.println(e);} return null;
}

public static ArrayList<String> select() throws Exception{
 try{
     Connection con = getConnection();
     PreparedStatement select = con.prepareStatement("SELECT ID_Pretplatnika, Adresa, Pretplatnik.Broj, Telefon, MIN(Datum_vazenja) "
             + "FROM Pretplatnik, Kreditna_kartica WHERE Pretplatnik.Broj = Kreditna_kartica.Broj GROUP BY Datum_vazenja LIMIT 1; ");
     ResultSet result = select.executeQuery();
     
     ArrayList<String> array = new ArrayList<String>();
     while(result.next()){
         System.out.print("ID_Pretplatnika: " + result.getString("ID_Pretplatnika"));
         System.out.print(" ");
         System.out.print("Adresa: " + result.getString("Adresa"));
         System.out.print(" ");
         System.out.print("Broj: " + result.getString("Pretplatnik.Broj"));
         System.out.print(" ");
         System.out.print("Telefon: " + result.getString("Telefon"));
         System.out.print(" ");
         System.out.println("Datum_vazenja: " + result.getString("MIN(Datum_vazenja)"));
         
         array.add(result.getString("MIN(Datum_vazenja)"));
     }
     System.out.println("Prikazan je korisnik kome će prvom isteći kreditna kartica.");
     return array;
 
} catch(Exception e){System.out.println(e);}
return null;
}

public static ArrayList<String> select1() throws Exception{
 try{
     Connection con = getConnection();
     PreparedStatement select1 = con.prepareStatement("SELECT ID_Rezervacije, ID_Predstave, Rezervacija.ID_Pretplatnika, Adresa, "
             + "Pretplatnik.Broj, Telefon, Datum_vazenja, Datum_rezervacije, Ukupna_cena FROM Pretplatnik, Kreditna_kartica, "
             + "Rezervacija WHERE UKUPNA_CENA = (SELECT MAX(Ukupna_cena) FROM Rezervacija) "
             + "AND Rezervacija.ID_Pretplatnika = Pretplatnik.ID_Pretplatnika AND Pretplatnik.Broj = Kreditna_kartica.Broj");
     ResultSet result = select1.executeQuery();
     
     ArrayList<String> array = new ArrayList<String>();
     while(result.next()){
         System.out.print("ID_Rezervacije: " + result.getString("ID_Rezervacije"));
         System.out.print(" ");
         System.out.print("ID_Predstave: " + result.getString("ID_Predstave"));
         System.out.print(" ");
         System.out.print("ID_Pretplatnika: " + result.getString("Rezervacija.ID_Pretplatnika"));
         System.out.print(" ");
         System.out.print("Adresa: " + result.getString("Adresa"));
         System.out.print(" ");
         System.out.print("Broj kartice: " + result.getString("Pretplatnik.Broj"));
         System.out.print(" ");
         System.out.print("Telefon: " + result.getString("Telefon"));
         System.out.print(" ");
         System.out.print("Datum_vazenja: " + result.getString("Datum_vazenja"));
         System.out.print(" ");
         System.out.print("Datum_rezervacije: " + result.getString("Datum_rezervacije"));
         System.out.print(" ");
         System.out.println("Ukupna_cena: " + result.getString("Ukupna_cena"));
         
         array.add(result.getString("Ukupna_cena"));
     }
     System.out.println("Prikazani su korisnici koji imaju najveći iznos za naplatu.");
     return array;
 
} catch(Exception e){System.out.println(e);}
return null;
}

public static ArrayList<String> select2() throws Exception{
 try{
     Connection con = getConnection();
     PreparedStatement select2 = con.prepareStatement("SELECT Producent.ID_Producenta, Ime, Prezime, "
             + "COUNT(POZORISNI_KOMAD.ID_PRODUCENTA) as Broj_pozorisnih_komada FROM POZORISNI_KOMAD, PRODUCENT "
             + "WHERE POZORISNI_KOMAD.ID_PRODUCENTA = PRODUCENT.ID_PRODUCENTA "
             + "GROUP BY POZORISNI_KOMAD.ID_PRODUCENTA ORDER BY Broj_pozorisnih_komada DESC LIMIT 1");
     ResultSet result = select2.executeQuery();
     
     ArrayList<String> array = new ArrayList<String>();
     while(result.next()){
         System.out.print("Producent: " + result.getString("Producent.ID_Producenta"));
         System.out.print(" ");
         System.out.print("Ime producenta: " + result.getString("Ime"));
         System.out.print(" ");
         System.out.print("Prezime producenta: " + result.getString("Prezime"));
         System.out.print(" ");
         System.out.println("Broj pozorisnih komada: " + result.getString("Broj_pozorisnih_komada"));
         
         array.add(result.getString("Broj_pozorisnih_komada"));
     }
     System.out.println("Prikazan je producent koji ima najviše različitih predstava.");
     return array;
 
} catch(Exception e){System.out.println(e);}
return null;
}

public static ArrayList<String> select3() throws Exception{
 try{
     Connection con = getConnection();
     PreparedStatement select3 = con.prepareStatement("SELECT ID_Predstave, Datum_odrzavanja, Broj_raspolozivih_mesta, Cena_ulaznice FROM Predstava ORDER BY Cena_ulaznice DESC");
     ResultSet result = select3.executeQuery();
     
     ArrayList<String> array = new ArrayList<String>();
     while(result.next()){
         System.out.print("ID_Predstave: " + result.getString("ID_Predstave"));
         System.out.print(" ");
         System.out.print("Datum_odrzavanja: " + result.getString("Datum_odrzavanja"));
         System.out.print(" ");
         System.out.print("Broj_raspolozivih_mesta: " + result.getString("Broj_raspolozivih_mesta"));
         System.out.print(" ");
         System.out.println("Cena_ulaznice: " + result.getString("Cena_ulaznice"));
         
         array.add(result.getString("Cena_ulaznice"));
     }
     System.out.println("Podaci su sortirani u opadajućem redosledu u zavisnosti od cene karata.");
     return array;
 
} catch(Exception e){System.out.println(e);}
return null;
}

public static ArrayList<String> select4() throws Exception{
 try{
     Connection con = getConnection();
     PreparedStatement select4 = con.prepareStatement("SELECT ID_Pretplatnika, Ukupna_cena, Broj FROM potrosennovacpretplatnika");
     ResultSet result = select4.executeQuery();
     
     ArrayList<String> array = new ArrayList<String>();
     while(result.next()){
         System.out.print("ID_Pretplatnika: " + result.getString("ID_Pretplatnika"));
         System.out.print(" ");
         System.out.print("Ukupna_cena: " + result.getString("Ukupna_cena"));
         System.out.print(" ");
         System.out.println("Broj: " + result.getString("Broj"));

         
         array.add(result.getString("Broj"));
     }
     System.out.println("Prikazano je koliko je svaki pretplatnik potrošio novca.");
     return array;
 
} catch(Exception e){System.out.println(e);}
return null;
}
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws Exception {
        select();
        select1();
        select2();
        select3();
        select4();

    }
}