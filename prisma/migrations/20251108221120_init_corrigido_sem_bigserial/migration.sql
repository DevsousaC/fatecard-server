-- CreateTable
CREATE TABLE "Aluno" (
    "ra" BIGINT NOT NULL,
    "card_RFID" UUID NOT NULL,
    "Nome" TEXT NOT NULL,
    "Curso" TEXT NOT NULL,

    CONSTRAINT "Aluno_pkey" PRIMARY KEY ("ra")
);

-- CreateTable
CREATE TABLE "Cartao" (
    "card_RFID" UUID NOT NULL,
    "data_expedicao" DATE NOT NULL,

    CONSTRAINT "Cartao_pkey" PRIMARY KEY ("card_RFID")
);

-- CreateTable
CREATE TABLE "Palestra" (
    "id" UUID NOT NULL,
    "horario_inicio" TIMESTAMP(3) NOT NULL,
    "horario_fim" TIMESTAMP(3) NOT NULL,
    "titulo" TEXT NOT NULL,
    "descricao" TEXT,
    "is_able_to_checkin" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Palestra_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Checkin" (
    "id" UUID NOT NULL,
    "horario_checkin" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "aluno_ra" BIGINT NOT NULL,
    "palestra_id" UUID NOT NULL,

    CONSTRAINT "Checkin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Certificado" (
    "id" UUID NOT NULL,
    "horario_expedicao" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "file_blob" BYTEA,
    "aluno_ra" BIGINT NOT NULL,
    "palestra_id" UUID NOT NULL,

    CONSTRAINT "Certificado_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Aluno_card_RFID_key" ON "Aluno"("card_RFID");

-- CreateIndex
CREATE UNIQUE INDEX "Checkin_aluno_ra_palestra_id_key" ON "Checkin"("aluno_ra", "palestra_id");

-- CreateIndex
CREATE UNIQUE INDEX "Certificado_aluno_ra_palestra_id_key" ON "Certificado"("aluno_ra", "palestra_id");

-- AddForeignKey
ALTER TABLE "Aluno" ADD CONSTRAINT "Aluno_card_RFID_fkey" FOREIGN KEY ("card_RFID") REFERENCES "Cartao"("card_RFID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Checkin" ADD CONSTRAINT "Checkin_aluno_ra_fkey" FOREIGN KEY ("aluno_ra") REFERENCES "Aluno"("ra") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Checkin" ADD CONSTRAINT "Checkin_palestra_id_fkey" FOREIGN KEY ("palestra_id") REFERENCES "Palestra"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Certificado" ADD CONSTRAINT "Certificado_aluno_ra_palestra_id_fkey" FOREIGN KEY ("aluno_ra", "palestra_id") REFERENCES "Checkin"("aluno_ra", "palestra_id") ON DELETE RESTRICT ON UPDATE CASCADE;
