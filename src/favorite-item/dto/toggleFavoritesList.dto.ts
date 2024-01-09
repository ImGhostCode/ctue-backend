import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsNumber, IsOptional } from 'class-validator';

export class ToggleFavoritesListDto {
  @ApiProperty()
  @IsNotEmpty()
  @IsNumber()
  wordId?: number;
}
