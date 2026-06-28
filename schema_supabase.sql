-- Schéma Supabase pour Gestion de Parc Auto
-- Exécuter dans l'éditeur SQL de Supabase Dashboard

CREATE TABLE voitures (
  id SERIAL PRIMARY KEY,
  marque TEXT NOT NULL,
  modele TEXT NOT NULL,
  immat TEXT NOT NULL,
  categorie TEXT DEFAULT 'Compacte',
  prixJour NUMERIC NOT NULL,
  assurance DATE,
  visite DATE,
  agrement DATE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE locations (
  id SERIAL PRIMARY KEY,
  date DATE NOT NULL,
  voiture TEXT NOT NULL,
  client TEXT NOT NULL,
  debut DATE NOT NULL,
  fin DATE NOT NULL,
  jours INTEGER NOT NULL,
  prixJour NUMERIC NOT NULL,
  total NUMERIC NOT NULL,
  paiement TEXT DEFAULT 'Especes',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE charges_fixes (
  id SERIAL PRIMARY KEY,
  date DATE NOT NULL,
  voiture TEXT DEFAULT '',
  type TEXT NOT NULL,
  montant NUMERIC NOT NULL,
  periode TEXT DEFAULT 'Mensuelle',
  mois TEXT DEFAULT '',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE charges_variables (
  id SERIAL PRIMARY KEY,
  date DATE NOT NULL,
  voiture TEXT DEFAULT '',
  type TEXT NOT NULL,
  montant NUMERIC NOT NULL,
  description TEXT DEFAULT '',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE charges_personnel (
  id SERIAL PRIMARY KEY,
  date DATE NOT NULL,
  montant NUMERIC NOT NULL,
  description TEXT DEFAULT '',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Optionnel : insérer des données de démo
INSERT INTO voitures (marque, modele, immat, categorie, prixJour, assurance, visite, agrement) VALUES
('SEAT', 'IBIZA', '12345-A-6', 'Compacte', 400, '2026-07-15', '2026-05-30', '2026-02-20'),
('PEUGEOT', '208 NOIR', '23456-B-7', 'Compacte', 300, '2026-09-21', '2026-06-10', '2026-03-28'),
('PEUGEOT', '208 GRIS', '34567-C-8', 'Compacte', 300, '2026-04-26', '2026-07-02', '2026-01-22'),
('DACIA', 'LOGANE NOIR', '45678-D-9', 'Economique', 250, '2026-10-11', '2026-08-14', '2026-04-01'),
('DACIA', 'SANDERO', '56789-E-0', 'Economique', 250, '2026-12-04', '2026-09-21', '2026-04-22'),
('HYUNDAI', 'I-30', '022A07', 'Compacte', 500, '2026-08-19', '2026-06-08', '2028-04-23'),
('MERCEDES', 'C220', '2555A40', 'Premium', 1200, '2026-11-17', '2026-11-09', '2026-12-09');

-- ===================== RLS (Row Level Security) =====================
-- Activer RLS sur toutes les tables
ALTER TABLE voitures ENABLE ROW LEVEL SECURITY;
ALTER TABLE locations ENABLE ROW LEVEL SECURITY;
ALTER TABLE charges_fixes ENABLE ROW LEVEL SECURITY;
ALTER TABLE charges_variables ENABLE ROW LEVEL SECURITY;
ALTER TABLE charges_personnel ENABLE ROW LEVEL SECURITY;

-- Politiques : uniquement accessible par kikukaito89@gmail.com
CREATE POLICY "Restreint voitures" ON voitures FOR ALL USING (auth.email() = 'kikukaito89@gmail.com') WITH CHECK (auth.email() = 'kikukaito89@gmail.com');
CREATE POLICY "Restreint locations" ON locations FOR ALL USING (auth.email() = 'kikukaito89@gmail.com') WITH CHECK (auth.email() = 'kikukaito89@gmail.com');
CREATE POLICY "Restreint charges_fixes" ON charges_fixes FOR ALL USING (auth.email() = 'kikukaito89@gmail.com') WITH CHECK (auth.email() = 'kikukaito89@gmail.com');
CREATE POLICY "Restreint charges_variables" ON charges_variables FOR ALL USING (auth.email() = 'kikukaito89@gmail.com') WITH CHECK (auth.email() = 'kikukaito89@gmail.com');
CREATE POLICY "Restreint charges_personnel" ON charges_personnel FOR ALL USING (auth.email() = 'kikukaito89@gmail.com') WITH CHECK (auth.email() = 'kikukaito89@gmail.com');
