-- Autoriser la lecture publique des images du bucket publicites
CREATE POLICY "Images publicites visibles"
ON storage.objects FOR SELECT TO anon, authenticated
USING (bucket_id = 'publicites');

-- Seuls les utilisateurs enregistrés comme administrateurs peuvent ajouter/modifier/supprimer les images
CREATE POLICY "Admin gerer images publicites"
ON storage.objects FOR ALL TO authenticated
USING (
  bucket_id = 'publicites' AND EXISTS (
    SELECT 1 FROM public.administrateurs WHERE user_id = auth.uid()
  )
)
WITH CHECK (
  bucket_id = 'publicites' AND EXISTS (
    SELECT 1 FROM public.administrateurs WHERE user_id = auth.uid()
  )
);
